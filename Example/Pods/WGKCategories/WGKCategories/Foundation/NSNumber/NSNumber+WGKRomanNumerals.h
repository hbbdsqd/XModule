//
//  NSNumber+RomanNumerals.h
//  SalesBagStandalone
//
//  Created by Patrick Zearfoss on 10/19/11.
//

//https://github.com/pzearfoss/NSNumber-RomanNumerals
#import <Foundation/Foundation.h>

@interface NSNumber (WGKRomanNumerals)
/**
 *  @author WGKCategories
 *
 *   A category on NSNumber that returns the value as a roman numeral 
 *
 *  @return <#return value description#>
 */
- (NSString *)wgk_romanNumeral;

@end