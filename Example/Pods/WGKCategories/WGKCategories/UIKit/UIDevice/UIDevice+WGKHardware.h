//
//  UIDevice+Hardware.h
//  TestTable
//
//  Created by Inder Kumar Rathore on 19/01/13.
//  Copyright (c) 2013 Rathore. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIDevice (WGKHardware)
+ (NSString *)wgk_platform;
+ (NSString *)wgk_platformString;


+ (NSString *)wgk_macAddress;

//Return the current device CPU frequency
+ (NSUInteger)wgk_cpuFrequency;
// Return the current device BUS frequency
+ (NSUInteger)wgk_busFrequency;
//current device RAM size
+ (NSUInteger)wgk_ramSize;
//Return the current device CPU number
+ (NSUInteger)wgk_cpuNumber;
//Return the current device total memory

/// 获取iOS系统的版本号
+ (NSString *)wgk_systemVersion;
/// 判断当前系统是否有摄像头
+ (BOOL)wgk_hasCamera;
/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)wgk_totalMemoryBytes;
/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)wgk_freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)wgk_freeDiskSpaceBytes;
/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)wgk_totalDiskSpaceBytes;
@end
