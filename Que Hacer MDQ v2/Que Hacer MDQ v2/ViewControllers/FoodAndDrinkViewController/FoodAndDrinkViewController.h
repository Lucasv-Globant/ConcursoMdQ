//
//  FoodAndDrinkViewController.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/10/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PIMainMenuController.h"

@interface FoodAndDrinkViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,PIMainMenuControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *foodAndDrinkUITableView;
@property (nonatomic, strong) PIMainMenuController *mainMenu;
@end
