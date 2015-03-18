//
//  WSMDQActivities.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSMDQActivities.h"



//@class Activity;

@interface WSMDQActivities ()

#pragma mark Instance variables
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *activitiesURL;
@property (nonatomic, strong) NSString *keyNameForResultStatus;    //Key of the WS result that will contain the status of the call
@property (nonatomic, strong) NSString *keyNameForResultEvents;  //Key of the WS result that will contain the events
@property (nonatomic, strong) NSDictionary *requiredParametersDictionary; //This dictionary holds the mandatory parameters for making the WS call.
@property WSMDQActivitiesDownloadResultCode lastRequestResultCode;

@end



@implementation WSMDQActivities : NSObject

#pragma mark Error Handling
//Error handling - Domain
NSString *const WSMDQActivitiesErrorDomain = @"com.globant.Que_Hacer_MDQ_v2";


- (NSError *)getNSErrorForCode:(WSMDQActivitiesDownloadResultCode)errorCode
{
    NSString *localizedDescription = nil;
    
    switch (errorCode)
    {
        case  WSMDQActivitiesDownloadResultCodeUnkownError:
            localizedDescription = NSLocalizedString(@"WSMDQActivities.Error.Unknown", @"");
            break;
        case WSMDQActivitiesDownloadResultCodeDataBaseError:
            localizedDescription = NSLocalizedString(@"WSMDQActivities.Error.DataBase", @"");
            break;
        case WSMDQActivitiesDownloadResultCodeIncorrectParameterError:
            localizedDescription = NSLocalizedString(@"WSMDQActivities.Error.IncorrectParameter", @"");
            break;
        case WSMDQActivitiesDownloadResultCodeIncorrectTokenError:
            localizedDescription = NSLocalizedString(@"WSMDQActivities.Error.IncorrectToken", @"");
            break;
        case WSMDQActivitiesDownloadResultCodeConnectivityError:
            localizedDescription = NSLocalizedString((@"WSMDQActivities.Error.Connectivity"), @"");
            break;
        default:
            localizedDescription = NSLocalizedString(@"WSMDQActivities.Error.Unknown", @"");
            break;
    }
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : localizedDescription};
    return [NSError errorWithDomain:WSMDQActivitiesErrorDomain code:errorCode userInfo:userInfo];
}


-(WSMDQActivitiesDownloadResultCode)getResultCodeFromResponseObject:(NSDictionary *)responseObject
{
    WSMDQActivitiesDownloadResultCode result = WSMDQActivitiesDownloadResultCodeUnkownError;
    
    if ([self responseObjectDownloaded:responseObject])
    {
        if ([self responseObjectDownloadedOk:responseObject])
        {
            result = WSMDQActivitiesDownloadResultCodeOk;
        }
        else
        {
            if ([self responseObjectDownloadedWithWarnings:responseObject])
            {
                result = WSMDQActivitiesDownloadResultCodeWarning;
            }
            else
            {
                if ([self responseObjectDownloadedWithErrors:(responseObject)])
                {
                    result = WSMDQActivitiesDownloadResultCodeDataBaseError;
                }
            }
            
        }
    }
    
    return result;
}


#pragma mark Initialization

-(WSMDQActivities *)init
{
    if (self = [super init])
    {
        self.downloadInProgress = NO;
        self.token = @"012345678901234567890123456789012";
        self.activitiesURL = [NSString stringWithFormat:@"%@/%@",WSMDQActivities_baseURL,WSMDQActivities_Activities];
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
    
    NSLog(@"Sending POST request...");
    
    NSMutableDictionary *paramsDictionary = [self.requiredParametersDictionary mutableCopy] ;
    
    [paramsDictionary addEntriesFromDictionary:filteringParameters];

    [manager POST:self.activitiesURL
       parameters:paramsDictionary
     
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(successBlock) //si el parametro success esta seteado...
         {
             if (![responseObject isKindOfClass:[NSDictionary class]])
             {
                 //A dictionary was expected, but something else was received
                 self.lastRequestResultCode = WSMDQActivitiesDownloadResultCodeUnkownError;
             }
             else
             {
                 self.lastRequestResultCode = [self getResultCodeFromResponseObject:responseObject];
             }
             
             NSArray* arrayOfJSONActivities = [responseObject objectForKey:@"Results"];
             for (NSDictionary *item in arrayOfJSONActivities)
                 {
                    Activity *activityItem = [Activity instanceFromDictionary:item];
                    [self.buffer addObject:activityItem];
                 }
                 
                 successBlock(self.buffer); //ejecuto esto (un bloque)
          }
         
     }
     
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         if(failureBlock) //si el parametro failure esta seteado...
         {
             self.lastRequestResultCode = WSMDQActivitiesDownloadResultCodeConnectivityError;
             NSError *resultError = [self getNSErrorForCode:self.lastRequestResultCode];
             failureBlock(resultError); //ejecuto esto (un bloque)
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
-(NSArray *)activitiesListFromResponseObject:(NSDictionary *)responseObject
{
    if ([self responseObjectDownloadedOk:responseObject] || [self responseObjectDownloadedWithWarnings:responseObject])
    {
        return [responseObject objectForKey:self.keyNameForResultEvents];
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
-(BOOL)responseObjectDownloaded:(NSDictionary *)responseObject

{
    return ([responseObject objectForKey:self.keyNameForResultStatus]);
}


/**
 *  The purpose of this function is to tell if a list of activities has been downloaded successfuly
 *  Receives a dictionary from a WSActivities Web service response.
 *  Returns YES if the parameter contains the key flag that corresponds to a success status
 */
-(BOOL)responseObjectDownloadedOk:(NSDictionary *) responseObject
{
    BOOL result = NO;
    
    if ([self responseObjectDownloaded:responseObject])
    {
        result = [[responseObject objectForKey:self.keyNameForResultStatus] isEqual:[NSNumber numberWithInt:0]];
    }
    
    return result;
}



/**
 *  The purpose of this function is to tell if a list of activities has been downloaded with warnings
 *  Receives a dictionary from a WSActivities Web service response.
 *  Returns YES if the parameter contains the key flag that corresponds to a warning.
 */
-(BOOL)responseObjectDownloadedWithWarnings:(NSDictionary *) responseObject
{
    BOOL result = NO;
    
    if ([self responseObjectDownloaded:responseObject])
    {
        result = [[responseObject objectForKey:self.keyNameForResultStatus] isEqual:[NSNumber numberWithInt:2]];
    }
    
    return result;
}


 /**
 *  The purpose of this function is to tell if a list of activities has been downloaded with errors
 *  Receives a dictionary from a WSActivities Web service response.
 *  Returns YES if the parameter contains the key flag that corresponds to an error.
 */
-(BOOL)responseObjectDownloadedWithErrors:(NSDictionary *) responseObject
{
    BOOL result = NO;
    
    if ([self responseObjectDownloaded:responseObject])
    {
        result = [[responseObject objectForKey:self.keyNameForResultStatus] isEqual:[NSNumber numberWithInt:1]];
    }
    
    return result;
}



#pragma mark Supporting methods - Date to String


-(NSString *)getDateInStringFormatWithNSDate:(NSDate *)date addingDays:(int)daysToAdd
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSDate *targetDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
    [df setDateFormat:@"dd"];
    NSString *dayString = [df stringFromDate:targetDate];
    
    [df setDateFormat:@"MM"];
    NSString *monthString = [df stringFromDate:targetDate];
    
    [df setDateFormat:@"yyyy"];
    NSString *yearString = [df stringFromDate:targetDate];
    
    return [NSString stringWithFormat:@"%@%@%@", yearString,monthString,dayString];
}

-(NSDate*)getNSDateFromNSString:(NSString*)str
{
    [NSDate alloc] init
}




#pragma mark Supporting methods - Deprecated
-(NSString *)getTimeStartOfDay
{
    return @"T000000";
}

-(NSString *)getTimeEndOfDay
{
    return @"T235959";
}

-(NSDictionary *)eventsFilteringParametersForToday
//Builds the parameters for the WS to filter (include) only today's and tomorrow's elements
{
    
    //Build the string for today (concatenated with the start of the day)
    NSString *stringForToday = [NSString stringWithFormat:[self getDateInStringFormatWithNSDate:[NSDate date] addingDays:0],[self getTimeStartOfDay]];
    
    //Build the string for tomorrow (concatenated with the end of the day)
    NSString *stringForTomorrow = [NSString stringWithFormat:[self getDateInStringFormatWithNSDate:[NSDate date] addingDays:1],[self getTimeEndOfDay]];
    
    //Build the NSDictionary and return it
    return @{@"FechaDesde" : stringForToday, @"FechaHasta" : stringForTomorrow};
    
}



@end