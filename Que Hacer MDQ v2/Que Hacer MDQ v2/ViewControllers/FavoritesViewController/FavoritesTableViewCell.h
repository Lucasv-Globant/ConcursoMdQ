//
//  FavoritesTableViewCell.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/7/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import "AppSettings.h"


//@protocol FavoritesTableViewCellDelegate
//@end

@protocol FavoritesTableViewCellDelegate <NSObject>
-(void)didTapOnGoToFavorite:(NSNumber*)activityId;
-(void)didTapOnDeleteFavorite:(NSNumber*)activityId;
@end

@interface FavoritesTableViewCell : UITableViewCell
    @property (strong, nonatomic) IBOutlet UIButton *btnDeleteFavorite;
    @property (strong, nonatomic) IBOutlet UIButton *btnGoToFavorite;
    @property (strong,nonatomic) Activity* activity;
    @property (nonatomic, assign) id<FavoritesTableViewCellDelegate> delegate;
@end



