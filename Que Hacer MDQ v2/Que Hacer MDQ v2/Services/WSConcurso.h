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
typedef void (^WSConcursoSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^WSConcursoFailure)(AFHTTPRequestOperation *operation, NSError *error);


+ (void) getAllActivitiesWithSuccess: (WSConcursoSuccess) SuccessBlock
                             andFailure: (WSConcursoFailure) FailureBlock;


@end
