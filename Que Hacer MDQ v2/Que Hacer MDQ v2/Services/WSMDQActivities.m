//
//  WSMDQActividades.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSMDQActivities.h"

@interface WSMDQActivities ()

#pragma mark Instance variables
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *activitiesURL;
@property (nonatomic, strong) NSString *keyNameForResultStatus;    //Key of the WS result that will contain the status of the call
@property (nonatomic, strong) NSString *keyNameForResultEvents;  //Key of the WS result that will contain the events
@property (nonatomic, strong) NSDictionary *requiredParametersDictionary; //This dictionary holds the mandatory parameters for making the WS call.

@end




@implementation WSMDQActivities : NSObject

#pragma mark Initialization

-(WSMDQActivities *)init
{
    if (self = [super init])
    {
        self.token = @"012345678901234567890123456789012";
        self.activitiesURL = [NSString stringWithFormat:@"%@/%@",WSMDQActividades_baseURL,WSMDQActividades_Activities];
        self.keyNameForResultStatus = @"ResultCode";
        self.keyNameForResultEvents = @"Results";
        self.requiredParametersDictionary = @{@"Token":self.token};
    }
    return self;
}




#pragma mark Web service requests
-(void)getEventsWithSuccess:(void (^)(NSDictionary *response))success
                    failure:(void (^)(NSError *error))failure
    withFilteringParameters:(NSDictionary *)filteringParameters

{
    
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
         if(success) //si el parametro success esta seteado...
         {
             
             if ([responseObject isKindOfClass:[NSDictionary class]])
             {
                 NSLog(@"DICCIONARIO DESCARGADO CON %lu ELEMENTOS",(unsigned long)[responseObject count]);
                 success(responseObject); //ejecuto esto (un bloque)
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
             failure(error); //ejecuto esto (un bloque)
         }
         
     }
     ];
    NSLog(@"GET REQUEST COMPLETED!");
    
}


-(void)getEvents:(void (^)(NSDictionary *response))success
         failure:(void (^)(NSError *error))failure
//Method for backwards compatibility. It invokes the method with an empty parameters dictionary
{
    
    [self getEventsWithSuccess:success failure:failure withFilteringParameters:@{}];
    
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

-(BOOL)activitiesListIsDownloaded:(NSDictionary *)aDictionary
//Based on the structure of a given dictionary, it will tell whether it has been downloaded or not.
{
    return ([aDictionary objectForKey:self.keyNameForResultStatus]);
}


-(BOOL)activitiesListDownloadedOk:(NSDictionary *) aDictionary
{
    BOOL result = NO;
    
    if ([self activitiesListIsDownloaded:aDictionary])
    {
        result = [[aDictionary objectForKey:self.keyNameForResultStatus] isEqual:[NSNumber numberWithInt:0]];
    }
    
    return result;
}



-(BOOL)activitiesListDownloadedWithWarnings:(NSDictionary *) aDictionary
{
    BOOL result = NO;
    
    if ([self activitiesListIsDownloaded:aDictionary])
    {
        result = [[aDictionary objectForKey:self.keyNameForResultStatus] isEqual:[NSNumber numberWithInt:2]];
    }
    
    return result;
}


-(BOOL)activitiesListDownloadedWithErrors:(NSDictionary *) aDictionary
{
    BOOL result = NO;
    
    if ([self activitiesListIsDownloaded:aDictionary])
    {
        result = [[aDictionary objectForKey:self.keyNameForResultStatus] isEqual:[NSNumber numberWithInt:1]];
    }
    
    return result;
}





#pragma mark Helper methods - Parameters builders

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
    return @{@"DateFrom" : stringForToday, @"DateTo" : stringForTomorrow};
    
}

@end