//
//  UITextField+Blocks.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UITextField (WGKBlocks)
@property (copy, nonatomic) BOOL (^wgk_shouldBegindEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^wgk_shouldEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^wgk_didBeginEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^wgk_didEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^wgk_shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
@property (copy, nonatomic) BOOL (^wgk_shouldReturnBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^wgk_shouldClearBlock)(UITextField *textField);

- (void)setWgk_shouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;
- (void)setWgk_shouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (void)setWgk_didBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
- (void)setWgk_didEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (void)setWgk_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (void)setWgk_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (void)setWgk_shouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;
@end
