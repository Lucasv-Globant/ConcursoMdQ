//
//  ActivitiesCollection.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 5/15/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ActivitiesCollection.h"
#import "Activity.h"
#import "Tag.h"

@interface ActivitiesCollection()
@property (nonatomic, strong) NSArray* activities;
@end

@implementation ActivitiesCollection

-(ActivitiesCollection*)initWithArray:(NSArray*)arrayOfActivities
//Initializes with an array of Activities
{
    if (self = [super init])
    {
        self.activities = arrayOfActivities;
    }
    return self;
}

-(NSArray*)filterActivitiesWithTagIds:(NSArray*)arrayOfNSNumbers
{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    for (NSNumber* tagId in arrayOfNSNumbers)
    {
        for (Activity* act in self.activities)
        {
            for (NSNumber* activityTagId in act.tags)
            {
                if ([tagId isEqualToNumber:activityTagId])//[tagId isEqualToNumber:activityTagId])
                {
                    [result addObject:act];
                }
            }
        }
        
    }
    
    return [NSArray arrayWithArray:result];
}

-(NSArray*)filterActivitiesWithKeyWords:(NSArray*)arrayOfStrings
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    /*
    for (NSString* keyWord in arrayOfStrings)
    {
        if ()
        {
            
        }
    }
    */
    return result;
}
@end
