//
//  NSObject+WGKReflection.h
//  NSObject-WGKReflection
//
//  Created by Jakey on 15/12/22.
//  Copyright © 2015年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WGKReflection)
//类名
- (NSString *)wgk_className;
+ (NSString *)wgk_className;
//父类名称
- (NSString *)wgk_superClassName;
+ (NSString *)wgk_superClassName;

//实例属性字典
-(NSDictionary *)wgk_propertyDictionary;

//属性名称列表
- (NSArray*)wgk_propertyKeys;
+ (NSArray *)wgk_propertyKeys;

//属性详细信息列表
- (NSArray *)wgk_propertiesInfo;
+ (NSArray *)wgk_propertiesInfo;

//格式化后的属性列表
+ (NSArray *)wgk_propertiesWithCodeFormat;

//方法列表
-(NSArray*)wgk_methodList;
+(NSArray*)wgk_methodList;

-(NSArray*)wgk_methodListInfo;

//创建并返回一个指向所有已注册类的指针列表
+ (NSArray *)wgk_registedClassList;
//实例变量
+ (NSArray *)wgk_instanceVariable;

//协议列表
-(NSDictionary *)wgk_protocolList;
+ (NSDictionary *)wgk_protocolList;


- (BOOL)wgk_hasPropertyForKey:(NSString*)key;
- (BOOL)wgk_hasIvarForKey:(NSString*)key;

@end
