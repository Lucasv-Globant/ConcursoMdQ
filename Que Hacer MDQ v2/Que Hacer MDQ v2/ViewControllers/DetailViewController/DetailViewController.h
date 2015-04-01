//
//  DetailViewController.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/25/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import "ActivityCategory.h"
@interface DetailViewController : UIViewController

@property (nonatomic, strong) Activity* activity;//The activity in question.

@property (nonatomic, strong) ActivityCategory* category;//The category the activity belongs to.
@end
