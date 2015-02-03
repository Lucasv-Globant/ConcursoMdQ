//
//  AppDelegate.h
//  SOAPTest2
//
//  Created by Lucas on 1/27/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOAPViewController.h"
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    HomeViewController *viewObj;
    UINavigationController *navObj;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)  HomeViewController *viewObj;
@property (strong, nonatomic) UINavigationController *navObj;
@end

