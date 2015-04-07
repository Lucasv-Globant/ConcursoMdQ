//
//  PIMainMenuCell.h
//  POIs iBeacons
//
//  Created by Matias Gelos on 07/10/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PIMainMenuCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *menuTitleLbl;

+ (PIMainMenuCell *)buildWithOwner:(id)owner;
+ (NSString *)cellIdentifier;
- (void)configureWithTitle:(NSString *)title;

@end
