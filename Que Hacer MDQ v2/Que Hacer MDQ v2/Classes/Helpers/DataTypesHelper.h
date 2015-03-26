//
//  DataTypesHelper.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/18/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTypesHelper : NSObject
+(NSDate*)getDateFromNSString:(NSString*)str;
+(NSDate*)getTimeFromNSString:(NSString*)str;
+(NSNumber*)stringToNSNumber:(NSString*) str;
+(NSNumber*)getHourOfCurrentTime;
+(NSDate*)qhmdqDateTimeStringToNSDate:(NSString*)str;
@end
