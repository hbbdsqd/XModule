//
// UITextField+Blocks.m
// UITextFieldBlocks
//
// Created by Håkon Bogen on 19.10.13.
// Copyright (c) 2013 Håkon Bogen. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
#import "UITextField+WGKBlocks.h"
#import <objc/runtime.h>
typedef BOOL (^WGKUITextFieldReturnBlock) (UITextField *textField);
typedef void (^WGKUITextFieldVoidBlock) (UITextField *textField);
typedef BOOL (^WGKUITextFieldCharacterChangeBlock) (UITextField *textField, NSRange range, NSString *replacementString);
@implementation UITextField (WGKBlocks)
static const void *WGKUITextFieldDelegateKey = &WGKUITextFieldDelegateKey;
static const void *WGKUITextFieldShouldBeginEditingKey = &WGKUITextFieldShouldBeginEditingKey;
static const void *WGKUITextFieldShouldEndEditingKey = &WGKUITextFieldShouldEndEditingKey;
static const void *WGKUITextFieldDidBeginEditingKey = &WGKUITextFieldDidBeginEditingKey;
static const void *WGKUITextFieldDidEndEditingKey = &WGKUITextFieldDidEndEditingKey;
static const void *WGKUITextFieldShouldChangeCharactersInRangeKey = &WGKUITextFieldShouldChangeCharactersInRangeKey;
static const void *WGKUITextFieldShouldClearKey = &WGKUITextFieldShouldClearKey;
static const void *WGKUITextFieldShouldReturnKey = &WGKUITextFieldShouldReturnKey;
#pragma mark UITextField Delegate methods
+ (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    WGKUITextFieldReturnBlock block = textField.wgk_shouldBegindEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, WGKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    WGKUITextFieldReturnBlock block = textField.wgk_shouldEndEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, WGKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (void)textFieldDidBeginEditing:(UITextField *)textField
{
   WGKUITextFieldVoidBlock block = textField.wgk_didBeginEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, WGKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (void)textFieldDidEndEditing:(UITextField *)textField
{
    WGKUITextFieldVoidBlock block = textField.wgk_didEndEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, WGKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    WGKUITextFieldCharacterChangeBlock block = textField.wgk_shouldChangeCharactersInRangeBlock;
    if (block) {
        return block(textField,range,string);
    }
    id delegate = objc_getAssociatedObject(self, WGKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
+ (BOOL)textFieldShouldClear:(UITextField *)textField
{
    WGKUITextFieldReturnBlock block = textField.wgk_shouldClearBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, WGKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}
+ (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    WGKUITextFieldReturnBlock block = textField.wgk_shouldReturnBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, WGKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    return YES;
}
#pragma mark Block setting/getting methods
- (BOOL (^)(UITextField *))wgk_shouldBegindEditingBlock
{
    return objc_getAssociatedObject(self, WGKUITextFieldShouldBeginEditingKey);
}
- (void)setWgk_shouldBegindEditingBlock:(BOOL (^)(UITextField *))shouldBegindEditingBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGKUITextFieldShouldBeginEditingKey, shouldBegindEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))wgk_shouldEndEditingBlock
{
    return objc_getAssociatedObject(self, WGKUITextFieldShouldEndEditingKey);
}
- (void)setWgk_shouldEndEditingBlock:(BOOL (^)(UITextField *))shouldEndEditingBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGKUITextFieldShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))wgk_didBeginEditingBlock
{
    return objc_getAssociatedObject(self, WGKUITextFieldDidBeginEditingKey);
}
- (void)setWgk_didBeginEditingBlock:(void (^)(UITextField *))didBeginEditingBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGKUITextFieldDidBeginEditingKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))wgk_didEndEditingBlock
{
    return objc_getAssociatedObject(self, WGKUITextFieldDidEndEditingKey);
}
- (void)setWgk_didEndEditingBlock:(void (^)(UITextField *))didEndEditingBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGKUITextFieldDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *, NSRange, NSString *))wgk_shouldChangeCharactersInRangeBlock
{
    return objc_getAssociatedObject(self, WGKUITextFieldShouldChangeCharactersInRangeKey);
}
- (void)setWgk_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGKUITextFieldShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))wgk_shouldReturnBlock
{
    return objc_getAssociatedObject(self, WGKUITextFieldShouldReturnKey);
}
- (void)setWgk_shouldReturnBlock:(BOOL (^)(UITextField *))shouldReturnBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGKUITextFieldShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))wgk_shouldClearBlock
{
    return objc_getAssociatedObject(self, WGKUITextFieldShouldClearKey);
}
- (void)setWgk_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGKUITextFieldShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
}
#pragma mark control method
/*
 Setting itself as delegate if no other delegate has been set. This ensures the UITextField will use blocks if no delegate is set.
 */
- (void)wgk_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, WGKUITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}
@end
