//
//  SplashViewController.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/26/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataTypesHelper.h"
#import "Synchronizer.h"
#import "CategoriesSelectionViewController.h"
#import "AppMain.h"

@interface SplashViewController : UIViewController<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *txtLoading;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
