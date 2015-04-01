//
//  ActivitiesListTableViewCell.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/1/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitiesListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelActivityName;
@property (strong, nonatomic) IBOutlet UILabel *labelActivityDescription;
@property (strong, nonatomic) IBOutlet UILabel *labelActivityLocation;
@property (strong, nonatomic) IBOutlet UIImageView *imageActivityIcon;

@end
