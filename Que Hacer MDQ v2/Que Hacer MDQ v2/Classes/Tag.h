//
//  Tag.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/17/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataTypesHelper.h"

@class Activity;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Activity *activity;
+(Tag*)instanceFromDictionary:(NSDictionary*)aDictionary;
+(Tag*)persistentInstanceFromDictionary:(NSDictionary*)aDictionary;
@end
