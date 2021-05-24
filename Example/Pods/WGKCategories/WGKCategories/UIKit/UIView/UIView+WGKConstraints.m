//
//  UIView+WGKConstraints.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/5/22.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIView+WGKConstraints.h"

@implementation UIView (WGKConstraints)
-(NSLayoutConstraint *)wgk_constraintForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && (firstItem = %@ || secondItem = %@)", attribute, self, self];
    NSArray *constraintArray = [self.superview constraints];
    
    if (attribute == NSLayoutAttributeWidth || attribute == NSLayoutAttributeHeight) {
        constraintArray = [self constraints];
    }
    
    NSArray *fillteredArray = [constraintArray filteredArrayUsingPredicate:predicate];
    if(fillteredArray.count == 0) {
        return nil;
    } else {
        return fillteredArray.firstObject;
    }
}

- (NSLayoutConstraint *)wgk_leftConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeLeft];
}

- (NSLayoutConstraint *)wgk_rightConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeRight];
}

- (NSLayoutConstraint *)wgk_topConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)wgk_bottomConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeBottom];
}

- (NSLayoutConstraint *)wgk_leadingConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)wgk_trailingConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)wgk_widthConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)wgk_heightConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeHeight];
}

- (NSLayoutConstraint *)wgk_centerXConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeCenterX];
}

- (NSLayoutConstraint *)wgk_centerYConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeCenterY];
}

- (NSLayoutConstraint *)wgk_baseLineConstraint {
    return [self wgk_constraintForAttribute:NSLayoutAttributeBaseline];
}
@end
