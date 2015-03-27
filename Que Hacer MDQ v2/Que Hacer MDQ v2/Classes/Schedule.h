//
//  Schedule.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/17/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataTypesHelper.h"

@class Activity;

@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSString * dayDescription;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) Activity *activity;
-(id)initWithDictionary:scheduleDictionary;
+(Schedule*)instanceFromDictionary:(NSDictionary*)aDictionary;
@end
