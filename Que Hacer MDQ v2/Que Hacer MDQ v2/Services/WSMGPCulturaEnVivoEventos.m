//
//  WSMGPCulturaEnVivoEventos.m
//  SOAPTest2
//
//  Created by Lucas on 2/3/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <Foundation/Foundation.h>
#import "WSMGPCulturaEnVivoEventos.h"

@interface WSMGPCulturaEnVivoEventos ()

#pragma mark Instance variables
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *relativePathForEventsCategoriesList;
@property (nonatomic, strong) NSString *relativePathForEventsSearch;
@property (nonatomic, strong) NSString *relativePathForEventDetail;
@property (nonatomic, strong) NSString *keyNameForResultStatus;    //Key of the WS result that will contain the status of the call
@property (nonatomic, strong) NSString *keyNameForResultEvents;  //Key of the WS result that will contain the events
@property (nonatomic, strong) NSDictionary *requiredParametersDictionary; //This dictionary holds the mandatory parameters for making the WS call.

@end





@implementation WSMGPCulturaEnVivoEventos : NSObject

#pragma mark Initialization

-(WSMGPCulturaEnVivoEventos *)init
{
    if (self = [super init])
    {
        self.token = @"012345678901234567890123456789012";
        self.baseURL = @"http://appsb.mardelplata.gob.ar";
        self.relativePathForEventsCategoriesList = @"consultas/wsCalendario/RESTServiceCalendario.svc/calendario/consultaAreas";
        self.relativePathForEventsSearch = @"consultas/wsCalendario/RESTServiceCalendario.svc/calendario/consultaEventos";
        self.relativePathForEventDetail = @"consultas/wsCalendario/RESTServiceCalendario.svc/calendario/consultaDetalleEvento";
        self.keyNameForResultStatus = @"Estado";
        self.keyNameForResultEvents = @"Eventos";
        self.requiredParametersDictionary = @{@"Token":self.token,@"IdArea":@2};
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
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",self.baseURL,self.relativePathForEventsSearch];
    [manager POST:url
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
-(NSArray *)eventsListFromResponse:(NSDictionary *)aDictionary
{
    if ([self eventsListDownloadedOk:aDictionary] || [self eventsListDownloadedWithWarnings:aDictionary])
    {
        return [aDictionary objectForKey:self.keyNameForResultEvents];
    }
    else
    {
        return nil;
    }
}


#pragma mark Helper methods - Status checks

-(BOOL)eventsListIsDownloaded:(NSDictionary *)aDictionary
//Based on the structure of a given dictionary, it will tell whether it has been downloaded or not.
{
    return ([aDictionary objectForKey:self.keyNameForResultStatus]);
}


-(BOOL)eventsListDownloadedOk:(NSDictionary *) aDictionary
{
    BOOL result = NO;
    
    if ([self eventsListIsDownloaded:aDictionary])
    {
        result = [[aDictionary objectForKey:self.keyNameForResultStatus] isEqual:@"Ok"];
    }
    
    return result;
}



-(BOOL)eventsListDownloadedWithWarnings:(NSDictionary *) aDictionary
{
    BOOL result = NO;
    
    if ([self eventsListIsDownloaded:aDictionary])
    {
        result = [[aDictionary objectForKey:self.keyNameForResultStatus] isEqual:@"Advertencia"];
    }
    
    return result;
}


-(BOOL)eventsListDownloadedWithErrors:(NSDictionary *) aDictionary
{
    BOOL result = NO;
    
    if ([self eventsListIsDownloaded:aDictionary])
    {
        result = [[aDictionary objectForKey:self.keyNameForResultStatus] isEqual:@"Error"];
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
    return @{@"FechaDesde" : stringForToday, @"FechaHasta" : stringForTomorrow};
    
}



@end