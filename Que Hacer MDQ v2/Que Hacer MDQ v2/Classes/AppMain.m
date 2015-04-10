//
//  AppMain.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/9/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "AppMain.h"

@interface AppMain ()
@property (nonatomic,strong) FavoritesViewController* favoritesViewController;
@property (nonatomic,strong) CategoriesSelectionViewController* categoriesSelectionViewController;
@property (nonatomic,strong) ActivitiesListViewController* activitiesListViewController;

@end

@implementation AppMain

#pragma mark - Singleton method
+ (instancetype) sharedInstance {
    
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

-(FavoritesViewController*)sharedFavoritesViewController
{
    if (!self.favoritesViewController)
    {
        self.favoritesViewController = [[FavoritesViewController alloc] initWithNibName:@"FavoritesViewController" bundle:nil];
    }
    return self.favoritesViewController;
}

-(CategoriesSelectionViewController*)sharedCategoriesSelectionViewController
{
    if (!self.categoriesSelectionViewController)
    {
        self.categoriesSelectionViewController = [[CategoriesSelectionViewController alloc] initWithNibName:@"CategoriesSelectionViewController" bundle:nil];
    }
    return self.categoriesSelectionViewController;
}

-(ActivitiesListViewController*)sharedActivitiesListViewController
{
    if (!self.activitiesListViewController)
    {
        self.activitiesListViewController = [[ActivitiesListViewController alloc] initWithNibName:@"ActivitiesListViewController" bundle:nil];
    }
    return self.activitiesListViewController;
}


@end
