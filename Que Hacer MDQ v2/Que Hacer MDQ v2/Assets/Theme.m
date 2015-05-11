//
//  Theme.m
//  Que Hacer MDQ v2
//
//  Created by Analia on 4/7/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "Theme.h"
#import <Foundation/Foundation.h>

@implementation Theme

+ (UIColor *) colorBlue
{
    return [self getUIColorObjectFromHexString:@"11a4d8" alpha:1.0f];
}
+ (UIColor *) colorDarkGrey{
    return [self getUIColorObjectFromHexString:@"4b4b4b" alpha:1.0f];
}

+(UIColor *) colorPink{
    return [self getUIColorObjectFromHexString:@"ff1689" alpha:1.0f];
}

+(UIColor *) colorGreen{
    return [self getUIColorObjectFromHexString:@"91cb1a" alpha:1.0f];
}

+(UIColor *) colorOliveGreen{
    return [self getUIColorObjectFromHexString:@"71a921" alpha:1.0f];
}

+ (UIFont *) fontButton {
    return [UIFont fontWithName:@"GOTHAM-BOLD" size:12];
}

+ (UIFont *) fontMedium {
    return [UIFont fontWithName:@"GOTHAM-MEDIUM" size:12];
}

+ (UIFont *) fontTitle {
    return [UIFont fontWithName:@"GOTHAM-BOOK" size:12];
}

+ (UIFont *) fontButton01 {
    return [UIFont fontWithName:@"GOTHAM-MEDIUM" size:7];
}

+ (UIFont *) fontButton02 {
    return [UIFont fontWithName:@"GOTHAM-MEDIUM" size:10];
}

#pragma mark private methods

+ (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha {
    // Convert hex string to an integer
    unsigned int hexint = [self intFromHexString:hexStr];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}

+ (unsigned int)intFromHexString:(NSString *)hexStr {
    unsigned int hexInt = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

@end
