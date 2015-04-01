//
//  AppSettings.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/30/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface AppSettings : NSObject

-(NSDictionary*)getCategoriesSelectionDictionary;
-(void)setCategoriesSelectionDictionary:(NSDictionary*)dict;
+ (instancetype) sharedInstance;

@end
