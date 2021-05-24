//
//  NSObject+WGKAddProperty.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSObject+WGKAddProperty.h"
#import <objc/runtime.h>

//objc_getAssociatedObject和objc_setAssociatedObject都需要指定一个固定的地址，这个固定的地址值用来表示属性的key，起到一个常量的作用。
static const void *WGKStringProperty = &WGKStringProperty;
static const void *WGKIntegerProperty = &WGKIntegerProperty;
//static char IntegerProperty;
@implementation NSObject (WGKAddProperty)

@dynamic wgk_stringProperty;
@dynamic wgk_integerProperty;

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个字符串属性
 */
-(void)setWgk_stringProperty:(NSString *)wgk_stringProperty{
    //use that a static const as the key
    objc_setAssociatedObject(self, WGKStringProperty, wgk_stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //use that property's selector as the key:
    //objc_setAssociatedObject(self, @selector(stringProperty), stringProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//get
-(NSString *)wgk_stringProperty{
    return objc_getAssociatedObject(self, WGKStringProperty);
}

//set
/**
 *  @brief  catgory runtime实现get set方法增加一个NSInteger属性
 */
-(void)setWgk_integerProperty:(NSInteger)wgk_integerProperty{
    NSNumber *number = [[NSNumber alloc]initWithInteger:wgk_integerProperty];
    objc_setAssociatedObject(self,WGKIntegerProperty, number, OBJC_ASSOCIATION_ASSIGN);
}
//get
-(NSInteger)wgk_integerProperty{
    return [objc_getAssociatedObject(self, WGKIntegerProperty) integerValue];
}

@end
