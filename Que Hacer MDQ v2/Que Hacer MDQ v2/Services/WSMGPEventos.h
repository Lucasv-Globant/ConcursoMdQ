//
//  WSMGPEventos.h
//  SOAPTest2
//
//  Created by Lucas on 2/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "AFNetworking.h"

@interface WSMGPEventos : NSObject

-(void)getEventsCategories:(void (^)(NSDictionary *response))success
                   failure:(void (^)(NSError *error))failure;

@end