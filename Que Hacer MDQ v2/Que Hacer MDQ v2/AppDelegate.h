//
//  AppDelegate.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"
#import "SplashViewController.h"
#import <MMDrawerController.h>
#import "CategoriesSelectionViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) MMDrawerController *sideBar;
@property (nonatomic, strong) UINavigationController *centerNavigation;
@property (nonatomic, strong) SplashViewController *mainController;
@property (strong, nonatomic) UIWindow *window;

- (MMDrawerController *)createSideBarStruct;

@end

