//
//  UITextField+WGKInputLimit.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 2016/11/29.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "UITextField+WGKInputLimit.h"
#import <objc/runtime.h>

static const void *WGKTextFieldInputLimitMaxLength = &WGKTextFieldInputLimitMaxLength;
@implementation UITextField (WGKInputLimit)

- (NSInteger)wgk_maxLength {
    return [objc_getAssociatedObject(self, WGKTextFieldInputLimitMaxLength) integerValue];
}
- (void)setWgk_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, WGKTextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(wgk_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)wgk_textFieldTextDidChange {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.wgk_maxLength > 0 && toBeString.length > self.wgk_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.wgk_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.wgk_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.wgk_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.wgk_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}
@end
