//
//  Tag.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 5/22/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataHelper.h"
#import "DataTypesHelper.h"
#import "Activity.h"

@class Activity;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * tagId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Activity *activity;

+(Tag*)persistentInstanceFromDictionary:(NSDictionary*)aDictionary;
+(Tag*)instanceFromDictionary:(NSDictionary*)aDictionary;

@end
