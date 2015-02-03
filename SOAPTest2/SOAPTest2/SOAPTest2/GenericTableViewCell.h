//
//  GenericTableViewCell.h
//  SOAPTest2
//
//  Created by Lucas on 2/3/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+AutoHeight.h"

@interface GenericTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelDescription;

-(GenericTableViewCell *)setDataWithDictionary:(NSDictionary *) aDictionary;
@end
