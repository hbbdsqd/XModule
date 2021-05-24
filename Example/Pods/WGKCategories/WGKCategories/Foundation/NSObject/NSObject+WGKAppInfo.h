//
//  NSObject+WGKAppInfo.h
//  WGKCategories
//
//  Created by nidom on 15/9/29.
//  Copyright © 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WGKAppInfo)
-(NSString *)wgk_version;
-(NSInteger)wgk_build;
-(NSString *)wgk_identifier;
-(NSString *)wgk_currentLanguage;
-(NSString *)wgk_deviceModel;
@end
