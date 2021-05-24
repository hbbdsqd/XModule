//
//  UITableViewCell+TS_delaysContentTouches.m
//  tableViewCellDelaysContentTouches
//
//  Created by Nicholas Hodapp on 1/31/14.
//  Copyright (c) 2014 Nicholas Hodapp. All rights reserved.
//

#import "UITableViewCell+WGKDelaysContentTouches.h"

@implementation UITableViewCell (WGKDelaysContentTouches)

- (UIScrollView*) wgk_scrollView
{
    id sv = self.contentView.superview;
    while ( ![sv isKindOfClass: [UIScrollView class]] && sv != self )
    {
        sv = [sv superview];
    }
    
    return sv == self ? nil : sv;
}

- (void) setWgk_delaysContentTouches:(BOOL)delaysContentTouches
{
    [self willChangeValueForKey: @"wgk_delaysContentTouches"];
    
    [[self wgk_scrollView] setDelaysContentTouches: delaysContentTouches];
    
    [self didChangeValueForKey: @"wgk_delaysContentTouches"];
}

- (BOOL) wgk_delaysContentTouches
{
    return [[self wgk_scrollView] delaysContentTouches];
}



@end
