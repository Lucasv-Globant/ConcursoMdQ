//
//  DataTypesHelper.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/18/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "DataTypesHelper.h"

@implementation DataTypesHelper


#pragma mark Supporting methods - Date to String


+(NSString *)getDateInStringFormatWithNSDate:(NSDate *)date addingDays:(int)daysToAdd
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSDate *targetDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
    [df setDateFormat:@"dd"];
    NSString *dayString = [df stringFromDate:targetDate];
    
    [df setDateFormat:@"MM"];
    NSString *monthString = [df stringFromDate:targetDate];
    
    [df setDateFormat:@"yyyy"];
    NSString *yearString = [df stringFromDate:targetDate];
    
    return [NSString stringWithFormat:@"%@%@%@", yearString,monthString,dayString];
}



#pragma mark Supporting methods - String to Date
+(NSDate*)getDateFromNSString:(NSString*)str
{
    NSDateFormatter* dsf = [[NSDateFormatter alloc] init];
    dsf.dateFormat = @"yyyyMMdd";
    dsf.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_AR"];
    NSDate* date = [dsf dateFromString:str];
    return [[NSDate alloc] initWithTimeInterval:0 sinceDate:date];
}

#pragma mark Supporting methods - String to Time
+(NSDate*)getTimeFromNSString:(NSString*)str
{
    NSDateFormatter* dsf = [[NSDateFormatter alloc] init];
    dsf.dateFormat = @"HHmmss";
    dsf.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_AR"];
    NSDate* date = [dsf dateFromString:str];
    return [[NSDate alloc] initWithTimeInterval:0 sinceDate:date];
}

#pragma mark NSString to NSNumber
+(NSNumber*)stringToNSNumber:(NSString*) str
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    return [f numberFromString:str];
}


+(NSDate*)qhmdqDateTimeStringToNSDate:(NSString*)str
{
    NSDateFormatter* dsf = [[NSDateFormatter alloc] init];
    dsf.dateFormat = @"yyyyMMddTHHmmss";
    dsf.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_AR"];
    return [dsf dateFromString:str];
}


#pragma mark Supporting methods - Hour of current time
+(NSNumber*)getHourOfCurrentTime
{
    //Set a date formater to hours only:
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH"];
    
    //Get current date & time:
    NSDate* now = [NSDate date];
    
    //Convert to hours (as string):
    NSString *hoursString = [df stringFromDate:now];
    
    //Convert the string to NSNumber and return it:
    return [DataTypesHelper stringToNSNumber:hoursString];
}


#pragma mark Supporting methods - Deprecated
+(NSString *)getTimeStartOfDay
{
    return @"T000000";
}

+(NSString *)getTimeEndOfDay
{
    return @"T235959";
}





@end
