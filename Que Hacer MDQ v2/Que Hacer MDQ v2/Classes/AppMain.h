//
//  AppMain.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/9/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoritesViewController.h"
#import "CategoriesSelectionViewController.h"
#import "ActivitiesListViewController.h"

@class FavoritesViewController;
@class CategoriesSelectionViewController;
@class ActivitiesListViewController;

@interface AppMain : NSObject
+ (instancetype) sharedInstance;
-(FavoritesViewController*) sharedFavoritesViewController;
-(CategoriesSelectionViewController*) sharedCategoriesSelectionViewController;
-(ActivitiesListViewController*) sharedActivitiesListViewController;
@end
