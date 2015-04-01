//
//  DetailViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/25/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageHeader;
@property (strong, nonatomic) IBOutlet UILabel *labelActivityName;
@property (strong, nonatomic) IBOutlet UILabel *labelActivityLocation1;
@property (strong, nonatomic) IBOutlet UILabel *labelActivityLocation2;
@property (strong, nonatomic) IBOutlet UILabel *labelActivityTime1;
@property (strong, nonatomic) IBOutlet UILabel *labelActivityTime2;
@property (strong, nonatomic) IBOutlet UILabel *labelActivityDetails1;
@property (strong, nonatomic) IBOutlet UILabel *labelActivityPhone1;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.labelActivityName.text = self.activity.name;
    self.labelActivityLocation1.text = self.activity.locationDetails;
    NSString* locationString;
    if ([self.activity.locationStreetOrRoute containsString:@"Ruta"] || [self.activity.locationStreetOrRoute containsString:@"Autovía"])
    {
        locationString = [NSString stringWithFormat:@"%@ Km.%@",self.activity.locationStreetOrRoute,self.activity.locationHouseNumberingOrKm];
    }
    else
    {
        locationString = [NSString stringWithFormat:@"%@ %@",self.activity.locationStreetOrRoute,self.activity.locationHouseNumberingOrKm];
    }
    self.labelActivityLocation2.text = locationString;
    
    self.labelActivityTime1.text = self.activity.visitingHoursString;
    self.labelActivityTime2.text = @"";
    self.labelActivityDetails1.text = self.activity.desc;
    self.labelActivityPhone1.text = self.activity.contactPhone1;
    self.navigationItem.hidesBackButton = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
