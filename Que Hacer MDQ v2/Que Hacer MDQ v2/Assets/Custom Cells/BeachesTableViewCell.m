//
//  BeachesTableViewCell.m
//  SOAPTest2
//
//  Created by Lucas on 1/28/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "BeachesTableViewCell.h"

@interface BeachesTableViewCell ()
    @property (strong, nonatomic) IBOutlet UILabel *beachName;
    @property (strong, nonatomic) IBOutlet UILabel *beachStreet;
    @property (strong, nonatomic) IBOutlet UILabel *beachHouseNumbering;
@end

@implementation BeachesTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellWithDictionary:(NSDictionary *)aDictionary
{
    [[self beachName] setText:[aDictionary objectForKey:@"descripcion"]];
    
    [[self beachHouseNumbering] setText:[aDictionary objectForKey:@"calle"]];
    
    [[self beachStreet] setText:[aDictionary objectForKey:@"numero"]];
}

@end
