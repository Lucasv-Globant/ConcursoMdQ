//
//  FavoritesTableViewCell.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/7/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "FavoritesTableViewCell.h"
#import "DetailViewController.h"

@implementation FavoritesTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnGoToFavorite:(id)sender
{
    [self.delegate didTapOnGoToFavorite:[self.activity objectForKey:@"activityId"]];
}



- (IBAction)btnDeleteFavorite:(id)sender
{
    [self.delegate didTapOnDeleteFavorite:[self.activity objectForKey:@"activityId"]];
}

-(void)populateCellWithDictionary:(NSDictionary*)aDictionary
{
    self.activity = aDictionary;
    [self.btnGoToFavorite setTitle:[aDictionary objectForKey:@"name"] forState:UIControlStateNormal];
}

@end
