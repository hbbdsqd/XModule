//
//  NSString+WGKEncrypt.m
//  WGKCategories (https://github.com/ghostlords/WGKCategories)
//
//  Created by Jakey on 15/1/26.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

// 加密解密工具 http://tool.chacuo.net/cryptdes
#import "NSString+WGKEncrypt.h"
#import "NSData+WGKEncrypt.h"
#import "NSData+WGKBase64.h"

@implementation NSString (WGKEncrypt)
-(NSString*)wgk_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] wgk_encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted wgk_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)wgk_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData wgk_dataWithBase64EncodedString:self] wgk_decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)wgk_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] wgk_encryptedWithDESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted wgk_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)wgk_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData wgk_dataWithBase64EncodedString:self] wgk_decryptedWithDESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)wgk_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] wgk_encryptedWith3DESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted wgk_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)wgk_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData wgk_dataWithBase64EncodedString:self] wgk_decryptedWith3DESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

@end
