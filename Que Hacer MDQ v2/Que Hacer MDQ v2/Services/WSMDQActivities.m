//
//  WSMDQActividades.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSMDQActivities.h"
#import "Que_Hacer_MDQ_v2-Swift.h"

@class Activity;

@interface WSMDQActivities ()

#pragma mark Instance variables
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *activitiesURL;
@property (nonatomic, strong) NSString *keyNameForResultStatus;    //Key of the WS result that will contain the status of the call
@property (nonatomic, strong) NSString *keyNameForResultEvents;  //Key of the WS result that will contain the events
@property (nonatomic, strong) NSDictionary *requiredParametersDictionary; //This dictionary holds the mandatory parameters for making the WS call.

@end



@implementation WSMDQActivities : NSObject

#pragma mark Error Handling
//Error handling - Domain
NSString *const WSMDQActivitiesErrorDomain = @"com.globant.Que_Hacer_MDQ_v2";

//Error handling - Localized description
/*
 WSMDQActivitiesUnkownError = -1,
 WSMDQActivitiesDataBaseError = 1000,
 WSMDQActivitiesIncorrectParameterError = 1001,
 WSMDQActivitiesIncorrectTokenError = 1002
 */
- (NSError *)getErrorCodeForCode:(WSMDQActivitiesErrorCode)errorCode
{
    NSString *localizedDescription = nil;
    
    switch (errorCode)
    {
        case  WSMDQActivitiesUnkownError:
            localizedDescription = NSLocalizedString(@"WSMDQActivities.Error.Unknown", @"");
            break;
        case WSMDQActivitiesDataBaseError:
            localizedDescription = NSLocalizedString(@"WSMDQActivities.Error.DataBase", @"");
            break;
        case WSMDQActivitiesIncorrectParameterError:
            localizedDescription = NSLocalizedString(@"WSMDQActivities.Error.IncorrectParameter", @"");
            break;
        case WSMDQActivitiesIncorrectTokenError:
            localizedDescription = NSLocalizedString(@"WSMDQActivities.Error.IncorrectToken", @"");
            break;
        default:
            localizedDescription = NSLocalizedString(@"WSMDQActivities.Error.Unknown", @"");
            break;
    }
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : localizedDescription};
    return [NSError errorWithDomain:WSMDQActivitiesErrorDomain code:errorCode userInfo:userInfo];
}



#pragma mark Initialization

-(WSMDQActivities *)init
{
    if (self = [super init])
    {
        self.downloadInProgress = NO;
        self.token = @"012345678901234567890123456789012";
        self.activitiesURL = [NSString stringWithFormat:@"%@/%@",WSMDQActividades_baseURL,WSMDQActividades_Activities];
        self.keyNameForResultStatus = @"ResultCode";
        self.keyNameForResultEvents = @"Results";
        self.requiredParametersDictionary = @{@"Token":self.token};
    }
    return self;
}




#pragma mark Web service requests
-(void)getActivitiesWithSuccess:(Success)successBlock
                    failure:(Failure)failureBlock
    withFilteringParameters:(NSDictionary *)filteringParameters

{
    self.downloadInProgress = YES;
    self.buffer = [[ NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSLog(@"Sending POST...");
    
    NSMutableDictionary *paramsDictionary = [self.requiredParametersDictionary mutableCopy] ;
    
    [paramsDictionary addEntriesFromDictionary:filteringParameters];

    [manager POST:self.activitiesURL
       parameters:paramsDictionary
     
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(successBlock) //si el parametro success esta seteado...
         {
             if ([responseObject isKindOfClass:[NSDictionary class]])
             {
                 
                 NSLog(@"DICCIONARIO DESCARGADO CON %lu ELEMENTOS",(unsigned long)[responseObject count]);
                 for (NSDictionary *item in responseObject)
                 {
                     Activity *activityItem = [[Activity alloc] initWithDictionary: item];
                     [self.buffer addObject:activityItem];
                 }
                 
                 successBlock(responseObject); //ejecuto esto (un bloque)
             }
             else
             {
                 NSLog(@"SE DESCARGO UN TIPO DE DATO NO ESPERADO!");
             }
             
         }
         
     }
     
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         if(failure) //si el parametro failure esta seteado...
         {
             failureBlock(error); //ejecuto esto (un bloque)
         }
         
     }
     ];
    NSLog(@"GET REQUEST COMPLETED!");
    
}


-(void)getAllActivities:(Success)successBlock
                failure:(Failure)failureBlock
//Method for backwards compatibility. It invokes the method with an empty parameters dictionary
{
    
    [self getActivitiesWithSuccess:successBlock failure:failureBlock withFilteringParameters:@{}];
    
}


#pragma mark Response Accessors
-(NSArray *)activitiesListFromResponse:(NSDictionary *)aDictionary
{
    if ([self activitiesListDownloadedOk:aDictionary] || [self activitiesListDownloadedWithWarnings:aDictionary])
    {
        return [aDictionary objectForKey:self.keyNameForResultEvents];
    }
    else
    {
        return nil;
    }
}


#pragma mark Helper methods - Status checks

/**
 * Based on the structure of a given dictionary, this function will tell whether it has been downloaded or not.
 *
*/
-(BOOL)activitiesListIsDownloaded:(NSDictionary *)aDictionary

{
    return ([aDictionary objectForKey:self.keyNameForResultStatus]);
}


/**
 *  The purpose of this function is to tell if a list of activities has been downloaded successfuly
 *  Receives a dictionary from a WSActivities Web service response.
 *  Returns YES if the parameter contains the key flag that corresponds to a success status
 */
-(BOOL)activitiesListDownloadedOk:(NSDictionary *) aDictionary
{
    BOOL result = NO;
    
    if ([self activitiesListIsDownloaded:aDictionary])
    {
        result = [[aDictionary objectForKey:self.keyNameForResultStatus] isEqual:[NSNumber numberWithInt:0]];
    }
    
    return result;
}



/**
 *  The purpose of this function is to tell if a list of activities has been downloaded with warnings
 *  Receives a dictionary from a WSActivities Web service response.
 *  Returns YES if the parameter contains the key flag that corresponds to a warning.
 */
-(BOOL)activitiesListDownloadedWithWarnings:(NSDictionary *) aDictionary
{
    BOOL result = NO;
    
    if ([self activitiesListIsDownloaded:aDictionary])
    {
        result = [[aDictionary objectForKey:self.keyNameForResultStatus] isEqual:[NSNumber numberWithInt:2]];
    }
    
    return result;
}


 /**
 *  The purpose of this function is to tell if a list of activities has been downloaded with errors
 *  Receives a dictionary from a WSActivities Web service response.
 *  Returns YES if the parameter contains the key flag that corresponds to an error.
 */
-(BOOL)activitiesListDownloadedWithErrors:(NSDictionary *) aDictionary
{
    BOOL result = NO;
    
    if ([self activitiesListIsDownloaded:aDictionary])
    {
        result = [[aDictionary objectForKey:self.keyNameForResultStatus] isEqual:[NSNumber numberWithInt:1]];
    }
    
    return result;
}



@end