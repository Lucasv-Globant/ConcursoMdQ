//
//  ActivitiesListViewController.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/25/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityCategory.h"
#import "CoreDataHelper.h"
#import "AppMain.h"

@interface ActivitiesListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *categoriesMenu;

@property (nonatomic,strong) NSArray* categories;

@end
