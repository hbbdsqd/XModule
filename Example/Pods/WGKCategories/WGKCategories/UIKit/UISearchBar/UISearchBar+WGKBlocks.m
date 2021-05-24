//
//  UISearchBar+WGKBlocks.m
//  UISearchBarBlocks
//
//  Created by Håkon Bogen on 20.10.13.
//  Copyright (c) 2013 Håkon Bogen. All rights reserved.
//

#import "UISearchBar+WGKBlocks.h"
#import <objc/runtime.h>

/* Only for convenience and readabilty in delegate methods */
typedef BOOL (^WGK_UISearchBarReturnBlock) (UISearchBar *searchBar);
typedef void (^WGK_UISearchBarVoidBlock) (UISearchBar *searchBar);
typedef void (^WGK_UISearchBarSearchTextBlock) (UISearchBar *searchBar,NSString *searchText);
typedef BOOL (^WGK_UISearchBarInRangeReplacementTextBlock) (UISearchBar *searchBar,NSRange range,NSString *text);
typedef void (^WGK_UISearchBarScopeIndexBlock)(UISearchBar *searchBar, NSInteger selectedScope);

@implementation UISearchBar (WGKBlocks)


static const void *WGK_UISearchBarDelegateKey                                = &WGK_UISearchBarDelegateKey;
static const void *WGK_UISearchBarShouldBeginEditingKey                      = &WGK_UISearchBarShouldBeginEditingKey;
static const void *WGK_UISearchBarTextDidBeginEditingKey                     = &WGK_UISearchBarTextDidBeginEditingKey;
static const void *WGK_UISearchBarShouldEndEditingKey                        = &WGK_UISearchBarShouldEndEditingKey;
static const void *WGK_UISearchBarTextDidEndEditingKey                       = &WGK_UISearchBarTextDidEndEditingKey;
static const void *WGK_UISearchBarTextDidChangeKey                           = &WGK_UISearchBarTextDidChangeKey;
static const void *WGK_UISearchBarShouldChangeTextInRangeKey                 = &WGK_UISearchBarShouldChangeTextInRangeKey;
static const void *WGK_UISearchBarSearchButtonClickedKey                                = &WGK_UISearchBarSearchButtonClickedKey;
static const void *WGK_UISearchBarBookmarkButtonClickedKey                                = &WGK_UISearchBarBookmarkButtonClickedKey;
static const void *WGK_UISearchBarCancelButtonClickedKey                                = &WGK_UISearchBarCancelButtonClickedKey;
static const void *WGK_UISearchBarResultsListButtonClickedKey                                = &WGK_UISearchBarResultsListButtonClickedKey;
static const void *WGK_UISearchBarSelectedScopeButtonIndexDidChangeKey                                = &WGK_UISearchBarSelectedScopeButtonIndexDidChangeKey;




#pragma mark UISearchBar delegate Methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    WGK_UISearchBarReturnBlock block = searchBar.wgk_completionShouldBeginEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]){
        return [delegate searchBarShouldBeginEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    WGK_UISearchBarVoidBlock block = searchBar.wgk_completionTextDidBeginEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]){
        [delegate searchBarTextDidBeginEditing:searchBar];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    WGK_UISearchBarReturnBlock block = searchBar.wgk_completionShouldEndEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]){
        return [delegate searchBarShouldEndEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
   WGK_UISearchBarVoidBlock block = searchBar.wgk_completionTextDidEndEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]){
        [delegate searchBarTextDidEndEditing:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    WGK_UISearchBarSearchTextBlock block = searchBar.wgk_completionTextDidChangeBlock;
    if (block) {
        block(searchBar,searchText);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:textDidChange:)]){
        [delegate searchBar:searchBar textDidChange:searchText];
    }
}
// called when text changes (including clear)
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    WGK_UISearchBarInRangeReplacementTextBlock block = searchBar.wgk_completionShouldChangeTextInRangeBlock;
    if (block) {
        return block(searchBar,range,text);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]){
        return [delegate searchBar:searchBar shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    WGK_UISearchBarVoidBlock block = searchBar.wgk_completionSearchButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]){
        [delegate searchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    WGK_UISearchBarVoidBlock block = searchBar.wgk_completionBookmarkButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarBookmarkButtonClicked:)]){
        [delegate searchBarBookmarkButtonClicked:searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    WGK_UISearchBarVoidBlock block = searchBar.wgk_completionCancelButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]){
        [delegate searchBarCancelButtonClicked:searchBar];
    }
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    WGK_UISearchBarVoidBlock block = searchBar.wgk_completionResultsListButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarResultsListButtonClicked:)]){
        [delegate searchBarResultsListButtonClicked:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    WGK_UISearchBarScopeIndexBlock block = searchBar.wgk_completionSelectedScopeButtonIndexDidChangeBlock;
    if (block) {
        block(searchBar,selectedScope);
    }
    id delegate = objc_getAssociatedObject(self, WGK_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)]){
        [delegate searchBar:searchBar selectedScopeButtonIndexDidChange:selectedScope];
    }
}


#pragma mark Block setting/getting methods
- (BOOL (^)(UISearchBar *))wgk_completionShouldBeginEditingBlock
{
    return objc_getAssociatedObject(self, WGK_UISearchBarShouldBeginEditingKey);
}

- (void)setWgk_completionShouldBeginEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldBeginEditingBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarShouldBeginEditingKey, searchBarShouldBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))wgk_completionTextDidBeginEditingBlock
{
    return objc_getAssociatedObject(self,WGK_UISearchBarTextDidBeginEditingKey);
}

- (void)setWgk_completionTextDidBeginEditingBlock:(void (^)(UISearchBar *))searchBarTextDidBeginEditingBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarTextDidBeginEditingKey, searchBarTextDidBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *))wgk_completionShouldEndEditingBlock
{
    return objc_getAssociatedObject(self, WGK_UISearchBarShouldEndEditingKey);
}

- (void)setWgk_completionShouldEndEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldEndEditingBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarShouldEndEditingKey, searchBarShouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))wgk_completionTextDidEndEditingBlock
{
    return objc_getAssociatedObject(self, WGK_UISearchBarTextDidEndEditingKey);
}

- (void)setWgk_completionTextDidEndEditingBlock:(void (^)(UISearchBar *))searchBarTextDidEndEditingBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarTextDidEndEditingKey, searchBarTextDidEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSString *))wgk_completionTextDidChangeBlock
{
    return objc_getAssociatedObject(self, WGK_UISearchBarTextDidChangeKey);
}

- (void)setWgk_completionTextDidChangeBlock:(void (^)(UISearchBar *, NSString *))searchBarTextDidChangeBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarTextDidChangeKey, searchBarTextDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *, NSRange, NSString *))wgk_completionShouldChangeTextInRangeBlock
{
    return objc_getAssociatedObject(self, WGK_UISearchBarShouldChangeTextInRangeKey);
}

- (void)setWgk_completionShouldChangeTextInRangeBlock:(BOOL (^)(UISearchBar *, NSRange, NSString *))searchBarShouldChangeTextInRangeBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarShouldChangeTextInRangeKey, searchBarShouldChangeTextInRangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))wgk_completionSearchButtonClickedBlock
{
    return objc_getAssociatedObject(self, WGK_UISearchBarSearchButtonClickedKey);
}

- (void)setWgk_completionSearchButtonClickedBlock:(void (^)(UISearchBar *))searchBarSearchButtonClickedBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarSearchButtonClickedKey, searchBarSearchButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))wgk_completionBookmarkButtonClickedBlock
{
    return objc_getAssociatedObject(self, WGK_UISearchBarBookmarkButtonClickedKey);
}

- (void)setWgk_completionBookmarkButtonClickedBlock:(void (^)(UISearchBar *))searchBarBookmarkButtonClickedBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarBookmarkButtonClickedKey, searchBarBookmarkButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))wgk_completionCancelButtonClickedBlock
{
    return objc_getAssociatedObject(self, WGK_UISearchBarCancelButtonClickedKey);
}

- (void)setWgk_completionCancelButtonClickedBlock:(void (^)(UISearchBar *))searchBarCancelButtonClickedBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarCancelButtonClickedKey, searchBarCancelButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))wgk_completionResultsListButtonClickedBlock
{
    return objc_getAssociatedObject(self, WGK_UISearchBarResultsListButtonClickedKey);
}

- (void)setWgk_completionResultsListButtonClickedBlock:(void (^)(UISearchBar *))searchBarResultsListButtonClickedBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarResultsListButtonClickedKey, searchBarResultsListButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSInteger))wgk_completionSelectedScopeButtonIndexDidChangeBlock
{
    return objc_getAssociatedObject(self, WGK_UISearchBarSelectedScopeButtonIndexDidChangeKey);
}

- (void)setWgk_completionSelectedScopeButtonIndexDidChangeBlock:(void (^)(UISearchBar *, NSInteger))searchBarSelectedScopeButtonIndexDidChangeBlock
{
    [self wgk_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, WGK_UISearchBarSelectedScopeButtonIndexDidChangeKey, searchBarSelectedScopeButtonIndexDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void)wgk_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UISearchBarDelegate>)self) {
        objc_setAssociatedObject(self, WGK_UISearchBarDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UISearchBarDelegate>)self;
    }
}

@end
