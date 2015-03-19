//
//  WSMDQActivities.h
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

//This is the only method you'll need to make use of this class.
//The success block receives an array containing activities (each activity being a NSDictionary)
//The failure block receives a NSError
-(void)getActivitiesWithSuccess:(Success)successBlock
                        failure:(Failure)failureBlock
        withFilteringParameters:(NSDictionary *)filteringParameters;


@property BOOL downloadInProgress;
@property BOOL downloadCompletedWithWarnings;
@property (nonatomic, strong) NSMutableArray *activitiesBuffer;
@property (nonatomic, strong) NSMutableArray *tagsBuffer;


//Error Handling
typedef enum {
    WSMDQActivitiesDownloadResultCodeUnkownError = -1,
    WSMDQActivitiesDownloadResultCodeOk = 0,
    WSMDQActivitiesDownloadResultCodeDataBaseError = 1000,
    WSMDQActivitiesDownloadResultCodeIncorrectParameterError = 1001,
    WSMDQActivitiesDownloadResultCodeIncorrectTokenError = 1002,
    WSMDQActivitiesDownloadResultCodeConnectivityError = 1003,
    WSMDQActivitiesDownloadResultCodeWarning = 2000
} WSMDQActivitiesDownloadResultCode;

extern NSString *const WSMDQActivitiesErrorDomain;

@end
