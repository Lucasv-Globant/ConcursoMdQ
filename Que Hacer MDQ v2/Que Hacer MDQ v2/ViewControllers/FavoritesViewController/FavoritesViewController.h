//
//  FavoritesViewController.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/7/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSettings.h"
#import "DetailViewController.h"
#import "Activity.h"
#import "FavoritesTableViewCell.h"
#import "PIMainMenuController.h"
#import "CategoriesSelectionViewController.h"

@interface FavoritesViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,FavoritesTableViewCellDelegate,PIMainMenuControllerDelegate>
@property (nonatomic, strong) NSArray* activities;
@property (strong, nonatomic) IBOutlet UILabel *lblNoFavorites;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) PIMainMenuController *mainMenu;

@end
