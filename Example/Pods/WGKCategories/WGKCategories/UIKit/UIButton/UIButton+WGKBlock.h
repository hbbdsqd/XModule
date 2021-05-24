//
//  UIButton+Block.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WGKTouchedButtonBlock)(NSInteger tag);

@interface UIButton (WGKBlock)
-(void)wgk_addActionHandler:(WGKTouchedButtonBlock)touchHandler;
@end
