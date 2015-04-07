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



/*
----------------------------------------------------------------------------------------
 Favorites Dictionary:
 Indexed by ActivityID (as NSString)
 Structure (elements of type NSDictionary):
    -activityId
    -name (NSString)
    -category (NSNumber)
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
    NSString* activityId = [favoriteDictionary objectForKey:@"activityId"];
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
