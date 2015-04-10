//
//  CategoriesSelectionViewController.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/27/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryCollectionViewCell.h"
#import "ActivityCategory.h"
#import "ActivitiesListViewController.h"
#import "PIMainMenuController.h"
#import "AppMain.h"

@interface CategoriesSelectionViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,PIMainMenuControllerDelegate>

@property (nonatomic, strong) PIMainMenuController *mainMenu;

@end
