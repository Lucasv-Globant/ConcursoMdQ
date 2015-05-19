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


-(BOOL)shouldSynchronize
{
    BOOL result = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate* lastSynchro = [defaults objectForKey:NSUserDefaults_KeyForDateOfLasSynchronization];
    if (lastSynchro)
    {
        NSComparisonResult comparison = [lastSynchro compare:[self synchronizationDateThreshold]];
        if ( comparison == NSOrderedDescending)
        {
            result = NO;
        }
    }
    return result;
    
}


-(NSDate*) synchronizationDateThreshold
//Returns the maximum accepted aging for the latest synchronization, in NSDate format
{
    NSDate* result = [NSDate date];
    NSInteger interval = -1 * [self synchronizationDaysThreshold] * 24 * 60 * 60;
    return [result dateByAddingTimeInterval:interval];
}

-(NSInteger) synchronizationDaysThreshold
//Returns the maximum accepted aging in terms of days for the latest synchronization
{
    //A week should be just fine
    return 7;
}


-(void) synchronizationDoneSuccessfully
//Sets today as the last day of a successful synchronization
//After a syncrhonization is made, this method should be called to keep track of the last update's date
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSDate date] forKey:NSUserDefaults_KeyForDateOfLasSynchronization];
}




/*
----------------------------------------------------------------------------------------
 Favorites Dictionary:
 Indexed by ActivityID (as NSString)
 Structure (elements of type NSDictionary):
    -activityId (NSNumber)
    -name (NSString)
    -category (NSNumber)
    -areaId (NSNumber)
 
-------------------------------------------------
*/

-(NSDictionary*)getFavoritesDictionary
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* favorites = [defaults dictionaryForKey:NSUserDefaults_KeyForFavorites];
    if (!favorites)
    {
        favorites = [[NSDictionary alloc] init];
    }
    return favorites;
    
}

-(void)setFavoritesDictionary:(NSDictionary*)dict
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dict forKey:NSUserDefaults_KeyForFavorites];
    [defaults synchronize];
}

-(void)addFavorite:(NSDictionary*)favoriteDictionary
{
    NSDictionary* favoritesDictionary = [self getFavoritesDictionary];
    NSMutableDictionary* favoritesMutableDictionary = [favoritesDictionary mutableCopy];
    NSString* activityId = [[favoriteDictionary objectForKey:@"activityId"] stringValue];
    [favoritesMutableDictionary setObject:favoriteDictionary forKey:activityId];
    favoritesDictionary = [[NSDictionary alloc] initWithDictionary:favoritesMutableDictionary];
    [self setFavoritesDictionary:favoritesDictionary];
}

-(void)removeFavoriteWithID:(NSString*)activityID
//Removes the favorite that corresponds to the given ActivityID
{
    NSDictionary* favoritesDictionary = [self getFavoritesDictionary];
    NSMutableDictionary* favoritesMutableDictionary = [favoritesDictionary mutableCopy];
    [favoritesMutableDictionary removeObjectForKey:activityID];
    favoritesDictionary = [[NSDictionary alloc] initWithDictionary:favoritesMutableDictionary];
    [self setFavoritesDictionary:favoritesDictionary];
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
