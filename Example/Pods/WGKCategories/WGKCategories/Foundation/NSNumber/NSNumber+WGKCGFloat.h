
//
//  NSNumber+CGFloat.h
//
//  Created by Alexey Aleshkov on 16.02.14.
//  Copyright (c) 2014 Alexey Aleshkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSNumber (WGKCGFloat)

- (CGFloat)wgk_CGFloatValue;

- (id)initWithWGKCGFloat:(CGFloat)value;

+ (NSNumber *)wgk_numberWithCGFloat:(CGFloat)value;

@end