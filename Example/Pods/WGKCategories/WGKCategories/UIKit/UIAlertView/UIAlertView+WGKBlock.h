//
//  UIAlertView+Block.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by 符现超 on 15/5/9.
//  Copyright (c) 2015年 http://weibo.com/u/1655766025 All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewWGKCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (WGKBlock)<UIAlertViewDelegate>

@property (nonatomic, copy) UIAlertViewWGKCallBackBlock wgk_alertViewCallBackBlock;

+ (void)wgk_alertWithCallBackBlock:(UIAlertViewWGKCallBackBlock)alertViewCallBackBlock
                            title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName
                otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
