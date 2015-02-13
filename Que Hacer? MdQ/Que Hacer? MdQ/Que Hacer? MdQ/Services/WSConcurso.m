//
//  WSConcurso.m
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/13/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "WSConcurso.h"
#import "Constants.h"

@implementation WSConcurso



+ (void) getAllActivitiesWithSuccess: (Success) successBlock
                          andFailure: (Failure) failureBlock {
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",ConcursoWS_baseURL,ConcursoWS_Activities];
    NSDictionary *parameters = @{@"token": token};
    
    [manager POST:url
       parameters:parameters
          success: successBlock
          failure: failureBlock
    ];
    
}

@end
