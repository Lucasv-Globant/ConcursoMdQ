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

-(void)getEvents:(void (^)(NSDictionary *response))success
         failure:(void (^)(NSError *error))failure;


-(BOOL)activitiesListIsDownloaded:(NSDictionary *)aDictionary;

-(BOOL)activitiesListDownloadedOk:(NSDictionary *) aDictionary;

-(BOOL)activitiesListDownloadedWithWarnings:(NSDictionary *) aDictionary;

-(BOOL)activitiesListDownloadedWithErrors:(NSDictionary *) aDictionary;

-(NSArray *)activitiesListFromResponse:(NSDictionary *)aDictionary;

@end
