//
//  Schedule.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/17/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "Schedule.h"
#import "Activity.h"


@implementation Schedule

@dynamic dayDescription;
@dynamic endDate;
@dynamic endTime;
@dynamic id;
@dynamic startDate;
@dynamic startTime;
@dynamic activity;

-(id)initWithDictionary:scheduleDictionary
{
    
    /*
     . schedule (array de dictionaries)
     dateStringStart (string)
     dateStringEnd (string)
     timeStringStart (string)
     timeStringEnd (string)
     dayDescription (string)

     */
    self.dayDescription = [scheduleDictionary objectForKey:@"dayDescription"];
    self.startDate = [scheduleDictionary objectForKey:@"dateStringStart"];
    self.endDate = [scheduleDictionary objectForKey:@"dateStringEnd"];
    self.startTime = [scheduleDictionary objectForKey:@"timeStringStart"];
    self.endTime = [scheduleDictionary objectForKey:@"timeStringEnd"];
    return self;
}

@end
