//
//  FoodAndDrinkDetailViewController.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/13/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import "ActivityCategory.h"
#import <Social/Social.h>

@interface FoodAndDrinkDetailViewController : UIViewController

@property (nonatomic, strong) Activity* activity;//The activity in question.
@property (nonatomic, strong) ActivityCategory* category;//The category the activity belongs to.
@property (strong, nonatomic) IBOutlet UILabel *labelActivityName;
@property (strong, nonatomic) IBOutlet UILabel *labelLocationDescription;
@property (strong, nonatomic) IBOutlet UITextView *textViewActivityDescription;
@property (strong, nonatomic) IBOutlet UIImageView *imageActivityHeader;
@property (strong, nonatomic) IBOutlet UILabel *labelLocationDescription2;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;

@end
