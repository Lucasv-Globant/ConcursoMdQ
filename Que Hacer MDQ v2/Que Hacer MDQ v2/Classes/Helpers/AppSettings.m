//
//  AppSettings.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/30/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "AppSettings.h"

@implementation AppSettings


-(NSDictionary*)getCategoriesSelectionDictionary
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults dictionaryForKey:NSUserDefaults_KeyForCategoriesSelection];
}

-(void)setCategoriesSelectionDictionary:(NSDictionary*)dict
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dict forKey:NSUserDefaults_KeyForCategoriesSelection];
    [defaults synchronize];
}

#pragma mark - Singleton method
+ (instancetype) sharedInstance {
    
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

@end
