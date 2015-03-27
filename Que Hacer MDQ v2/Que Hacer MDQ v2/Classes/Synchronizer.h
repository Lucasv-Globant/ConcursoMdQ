//
//  Synchronizer.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/19/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSMDQActivities.h"
#import "Activity.h"
#import "Tag.h"
#import "Schedule.h"

@interface Synchronizer : NSObject

//Blocks
typedef void (^SyncSuccess)(NSMutableArray *json);
typedef void (^SyncFailure)(NSError *error);

@property (nonatomic, strong) WSMDQActivities* webserviceInstance;
@property (nonatomic, strong) NSArray* tagsJSON;
@property (nonatomic, strong) NSArray* activitiesJSON;
@property (nonatomic, strong) NSArray* tagObjects;
@property (nonatomic, strong) NSArray* activityObjects;

-(void)syncWithSuccess:(SyncSuccess)successBlock
               failure:(SyncFailure)failureBlock;

@end
