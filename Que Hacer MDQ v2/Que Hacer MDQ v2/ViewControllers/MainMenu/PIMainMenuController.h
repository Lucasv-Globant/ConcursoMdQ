//
//  PIMainMenuController.h
//  Que Hacer MDQ v2
//
//  Created by Matias Gelos on 07/10/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PIMainMenuControllerDelegate <NSObject>


- (void)didSelectInteres;
- (void)didSelectSearch;
- (void)didSelectAllEvent;
- (void)didSelectFavorite;
- (void)didSelectGastronomia;

@end

@interface PIMainMenuController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id<PIMainMenuControllerDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;


@end
