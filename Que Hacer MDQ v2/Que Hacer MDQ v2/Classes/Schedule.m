//
//  Schedule.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 5/22/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "Schedule.h"
#import "Activity.h"


@implementation Schedule

@dynamic dayDescription;
@dynamic endDate;
@dynamic endTime;
@dynamic scheduleId;
@dynamic startDate;
@dynamic startTime;
@dynamic activity;



-(id)initWithDictionary:scheduleDictionary
{
    //Get the description:
    self.dayDescription = [scheduleDictionary objectForKey:@"dayDescription"];
    
    //Convert the start date string (format:yyyyMMdd) to NSDate:
    NSString* strStartDate = [scheduleDictionary objectForKey:@"dateStringStart"];
    self.startDate = [DataTypesHelper getDateFromNSString:strStartDate];
    
    //Convert the end date string (format:yyyyMMdd) to NSDate:
    NSString* strEndDate = [scheduleDictionary objectForKey:@"dateStringEnd"];
    self.endDate = [DataTypesHelper getDateFromNSString:strEndDate];
    
    //Convert the start time (format:hhmmss) to NSDate:
    NSString* strStartTime = [scheduleDictionary objectForKey:@"timeStringStart"];
    self.startTime = [DataTypesHelper getTimeFromNSString:strStartTime];
    
    //Convert the end time (format:hhmmss) to NSDate:
    NSString* strEndtime = [scheduleDictionary objectForKey:@"timeStringEnd"];
    self.endTime = [DataTypesHelper getTimeFromNSString:strEndtime];
    
    return self;
}


+(Schedule*)instanceFromDictionary:(NSDictionary*)aDictionary
{
    //TO BE COMPLETED
    return [[Schedule alloc] init];
}

@end
