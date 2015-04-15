//
//  MapViewController.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/14/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Activity.h"
#import "Area.h"
@interface MapViewController : UIViewController<MKMapViewDelegate>
@property (nonatomic,strong) Activity* activity;
//-(void)setupforSingleActivity:(Activity*)activity;
@end
