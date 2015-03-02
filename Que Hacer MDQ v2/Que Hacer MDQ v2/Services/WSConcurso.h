//
//  WSConcurso.h
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/13/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface WSConcurso : NSObject

//Blocks
typedef void (^Success)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^Failure)(AFHTTPRequestOperation *operation, NSError *error);


+ (void) getAllActivitiesWithSuccess: (Success) SuccessBlock
                             andFailure: (Failure) FailureBlock;


@end
