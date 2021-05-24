//
//  UITextField+History.m
//  Demo
//
//  Created by DamonDing on 15/5/26.
//  Copyright (c) 2015年 morenotepad. All rights reserved.
//

#import "UITextField+WGKHistory.h"
#import <objc/runtime.h>

#define wgk_history_X(view) (view.frame.origin.x)
#define wgk_history_Y(view) (view.frame.origin.y)
#define wgk_history_W(view) (view.frame.size.width)
#define wgk_history_H(view) (view.frame.size.height)

static char kTextFieldIdentifyKey;
static char kTextFieldHistoryviewIdentifyKey;

#define wgk_ANIMATION_DURATION 0.3f
#define wgk_ITEM_HEIGHT 40
#define wgk_CLEAR_BUTTON_HEIGHT 45
#define wgk_MAX_HEIGHT 300


@interface UITextField ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *wgk_historyTableView;

@end


@implementation UITextField (WGKHistory)

- (NSString*)wgk_identify {
    return objc_getAssociatedObject(self, &kTextFieldIdentifyKey);
}

- (void)setWgk_identify:(NSString *)identify {
    objc_setAssociatedObject(self, &kTextFieldIdentifyKey, identify, OBJC_ASSOCIATION_RETAIN);
}

- (UITableView*)wgk_historyTableView {
    UITableView* table = objc_getAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey);
    
    if (table == nil) {
        table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITextFieldHistoryCell"];
        table.layer.borderColor = [UIColor grayColor].CGColor;
        table.layer.borderWidth = 1;
        table.delegate = self;
        table.dataSource = self;
        objc_setAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey, table, OBJC_ASSOCIATION_RETAIN);
    }
    
    return table;
}

- (NSArray*)wgk_loadHistroy {
    if (self.wgk_identify == nil) {
        return nil;
    }

    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+WGKHistory"];
    
    if (dic != nil) {
        return [dic objectForKey:self.wgk_identify];
    }

    return nil;
}

- (void)wgk_synchronize {
    if (self.wgk_identify == nil || [self.text length] == 0) {
        return;
    }
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [def objectForKey:@"UITextField+WGKHistory"];
    NSArray* history = [dic objectForKey:self.wgk_identify];
    
    NSMutableArray* newHistory = [NSMutableArray arrayWithArray:history];
    
    __block BOOL haveSameRecord = false;
    __weak typeof(self) weakSelf = self;
    
    [newHistory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSString*)obj isEqualToString:weakSelf.text]) {
            *stop = true;
            haveSameRecord = true;
        }
    }];
    
    if (haveSameRecord) {
        return;
    }
    
    [newHistory addObject:self.text];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:newHistory forKey:self.wgk_identify];
    
    [def setObject:dic2 forKey:@"UITextField+WGKHistory"];
    
    [def synchronize];
}

- (void) wgk_showHistory; {
    NSArray* history = [self wgk_loadHistroy];
    
    if (self.wgk_historyTableView.superview != nil || history == nil || history.count == 0) {
        return;
    }
    
    CGRect frame1 = CGRectMake(wgk_history_X(self), wgk_history_Y(self) + wgk_history_H(self) + 1, wgk_history_W(self), 1);
    CGRect frame2 = CGRectMake(wgk_history_X(self), wgk_history_Y(self) + wgk_history_H(self) + 1, wgk_history_W(self), MIN(wgk_MAX_HEIGHT, wgk_ITEM_HEIGHT * history.count + wgk_CLEAR_BUTTON_HEIGHT));
    
    self.wgk_historyTableView.frame = frame1;
    
    [self.superview addSubview:self.wgk_historyTableView];
    
    [UIView animateWithDuration:wgk_ANIMATION_DURATION animations:^{
        self.wgk_historyTableView.frame = frame2;
    }];
}

- (void) wgk_clearHistoryButtonClick:(UIButton*) button {
    [self wgk_clearHistory];
    [self wgk_hideHistroy];
}

- (void)wgk_hideHistroy; {
    if (self.wgk_historyTableView.superview == nil) {
        return;
    }

    CGRect frame1 = CGRectMake(wgk_history_X(self), wgk_history_Y(self) + wgk_history_H(self) + 1, wgk_history_W(self), 1);
    
    [UIView animateWithDuration:wgk_ANIMATION_DURATION animations:^{
        self.wgk_historyTableView.frame = frame1;
    } completion:^(BOOL finished) {
        [self.wgk_historyTableView removeFromSuperview];
    }];
}

- (void) wgk_clearHistory; {
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    
    [def setObject:nil forKey:@"UITextField+WGKHistory"];
    [def synchronize];
}


#pragma mark tableview datasource
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
    return [self wgk_loadHistroy].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITextFieldHistoryCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITextFieldHistoryCell"];
    }
    
    cell.textLabel.text = [self wgk_loadHistroy][indexPath.row];
    
    return cell;
}
#pragma clang diagnostic pop

#pragma mark tableview delegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section; {
    UIButton* clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(wgk_clearHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return clearButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
    return wgk_ITEM_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return wgk_CLEAR_BUTTON_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
    self.text = [self wgk_loadHistroy][indexPath.row];
    [self wgk_hideHistroy];
}

@end
