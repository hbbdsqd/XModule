//
//  NSData+WGKHash.h
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/6/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (WGKHash)
/**
 *  @brief  md5 NSData
 */
@property (readonly) NSData *wgk_md5Data;
/**
 *  @brief  sha1Data NSData
 */
@property (readonly) NSData *wgk_sha1Data;
/**
 *  @brief  sha256Data NSData
 */
@property (readonly) NSData *wgk_sha256Data;
/**
 *  @brief  sha512Data NSData
 */
@property (readonly) NSData *wgk_sha512Data;

/**
 *  @brief  md5 NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)wgk_hmacMD5DataWithKey:(NSData *)key;
/**
 *  @brief  sha1Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)wgk_hmacSHA1DataWithKey:(NSData *)key;
/**
 *  @brief  sha256Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)wgk_hmacSHA256DataWithKey:(NSData *)key;
/**
 *  @brief  sha512Data NSData
 *
 *  @param key 密钥
 *
 *  @return 结果
 */
- (NSData *)wgk_hmacSHA512DataWithKey:(NSData *)key;
@end
