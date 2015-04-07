//
//  PIMainMenuCell.m
//  POIs iBeacons
//
//  Created by Matias Gelos on 07/10/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "PIMainMenuCell.h"
#import "Theme.h"


static NSString *cellIdentifier = @"PAMainMenuCellIdentifier";

@implementation PIMainMenuCell

#pragma mark - PAMainMenuCell

+ (PIMainMenuCell *)buildWithOwner:(id)owner {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:owner options:nil] objectAtIndex:0];
}

+ (NSString *)cellIdentifier {
    return cellIdentifier;
}

- (void)configureWithTitle:(NSString *)title {
    self.menuTitleLbl.text = title;
    self.menuTitleLbl.font = [Theme fontTitle];
    [self.menuTitleLbl setTextColor:[Theme colorDarkGrey]];

}

@end
