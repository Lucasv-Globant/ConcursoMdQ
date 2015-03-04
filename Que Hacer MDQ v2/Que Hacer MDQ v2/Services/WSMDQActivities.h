//
//  WSMDQActividades.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "AFNetworking.h"
#import "Constants.h"


@interface WSMDQActivities : NSObject

//Blocks
typedef void (^Success)(NSMutableArray *activitiesArray);
typedef void (^Failure)(NSError *error);

-(void)getAllActivities:(Success)successBlock
         failure:(Failure)failureBlock;


@property BOOL downloadInProgress;
@property BOOL downloadCompletedWithWarnings;
@property (nonatomic, strong) NSMutableArray *buffer;


-(NSArray *)activitiesListFromResponse:(NSDictionary *)aDictionary;


//Error Handling
typedef enum {
    WSMDQActivitiesUnkownError = -1,
    WSMDQActivitiesDataBaseError = 1000,
    WSMDQActivitiesIncorrectParameterError = 1001,
    WSMDQActivitiesIncorrectTokenError = 1002
} WSMDQActivitiesErrorCode;

extern NSString *const WSMDQActivitiesErrorDomain;


@end
