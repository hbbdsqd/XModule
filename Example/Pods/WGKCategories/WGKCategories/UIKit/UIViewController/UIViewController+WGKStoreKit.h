//
//  UIViewController+StoreKit.h
//  Picks
//
//  Created by Joe Fabisevich on 8/12/14.
//  Copyright (c) 2014 Snarkbots. All rights reserved.
//  https://github.com/mergesort/UIViewController-StoreKit

#import <UIKit/UIKit.h>

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Constants

#define affiliateToken @"10laQX"

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface UIViewController (WGKStoreKit)

@property NSString *wgk_campaignToken;
@property (nonatomic, copy) void (^wgk_loadingStoreKitItemBlock)(void);
@property (nonatomic, copy) void (^wgk_loadedStoreKitItemBlock)(void);

- (void)wgk_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier;

+ (NSURL*)wgk_appURLForIdentifier:(NSInteger)identifier;

+ (void)wgk_openAppURLForIdentifier:(NSInteger)identifier;
+ (void)wgk_openAppReviewURLForIdentifier:(NSInteger)identifier;

+ (BOOL)wgk_containsITunesURLString:(NSString*)URLString;
+ (NSInteger)wgk_IDFromITunesURL:(NSString*)URLString;

@end
