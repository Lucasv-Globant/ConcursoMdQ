//
//  WSMGPEventos.m
//  SOAPTest2
//
//  Created by Lucas on 2/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSMGPEventos.h"

@interface WSMGPEventos ()

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *relativePathForEventsCategoriesList;
@property (nonatomic, strong) NSString *relativePathForEventsSearch;
@property (nonatomic, strong) NSString *relativePathForEventDetail;

@end





@implementation WSMGPEventos : NSObject


-(WSMGPEventos *)init
{
    if (self = [super init])
    {
        self.baseURL = @"http://turismomardelplata.gov.ar";
        self.relativePathForEventsCategoriesList = @"WS/TurismoWS.svc/Evento/Categorias";
        self.relativePathForEventsSearch = @"WS/TurismoWS.svc/Evento/Buscar";
        self.relativePathForEventDetail = @"WS/TurismoWS.svc/Evento/Detalle";
    }
    return self;
}


-(void)getEventsCategories:(void (^)(NSDictionary *response))success
                                      failure:(void (^)(NSError *error))failure
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSLog(@"Sending POST...");
    
    NSDictionary *paramsDictionary = @{@"Token":@"012345678901234567890123456789012"};
    NSString *url = [NSString stringWithFormat:@"%@/%@",self.baseURL,self.relativePathForEventsCategoriesList];
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


@end