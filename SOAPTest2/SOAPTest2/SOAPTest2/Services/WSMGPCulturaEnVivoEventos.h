//
//  WSMGPCulturaEnVivoEventos.h
//  SOAPTest2
//
//  Created by Lucas on 2/3/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "AFNetworking.h"

@interface WSMGPCulturaEnVivoEventos : NSObject

-(void)getEvents:(void (^)(NSDictionary *response))success
         failure:(void (^)(NSError *error))failure;



-(BOOL)eventsListIsDownloaded:(NSDictionary *)aDictionary;

-(BOOL)eventsListDownloadedOk:(NSDictionary *) aDictionary;

-(BOOL)eventsListDownloadedWithWarnings:(NSDictionary *) aDictionary;

-(BOOL)eventsListDownloadedWithErrors:(NSDictionary *) aDictionary;

-(NSArray *)eventsListFromResponse:(NSDictionary *)aDictionary;

@end