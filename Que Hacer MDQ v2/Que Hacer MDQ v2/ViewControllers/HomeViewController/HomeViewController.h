//
//  HomeViewController.h
//  SOAPTest2
//
//  Created by Lucas on 2/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventosViewController.h"
#import "PIMainMenuController.h"


@interface HomeViewController : UIViewController <PIMainMenuControllerDelegate>
@property (nonatomic, strong) PIMainMenuController *mainMenu;
@end
