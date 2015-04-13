//
//  FoodAndDrinkDetailViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/13/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "FoodAndDrinkDetailViewController.h"

@interface FoodAndDrinkDetailViewController ()

@end

@implementation FoodAndDrinkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.labelActivityName.text = self.activity.name;
    NSString* locationStringLine1 = self.activity.locationDetails;
    NSString* locationStringLine2 = @"";
    
    if ([self.activity.locationStreetOrRoute containsString:@"Ruta"] || [self.activity.locationStreetOrRoute containsString:@"Autovía"])
    {
        locationStringLine2 = [NSString stringWithFormat:@"%@ Km.%@",self.activity.locationStreetOrRoute,self.activity.locationHouseNumberingOrKm];
    }
    else
    {
        locationStringLine2 = [NSString stringWithFormat:@"%@ %@",self.activity.locationStreetOrRoute,self.activity.locationHouseNumberingOrKm];
    }

    if ([locationStringLine1 isEqual: @""])
    {
        self.labelLocationDescription.text = locationStringLine2;
        self.labelLocationDescription2.text = @"";
    }
    else
    {
        self.labelLocationDescription.text = locationStringLine1;
        self.labelLocationDescription2.text = locationStringLine2;
    }
    
    //self.textViewActivityTime.text = self.activity.visitingHoursString;
    self.textViewActivityDescription.text = self.activity.desc;
    //self.labelActivityPhone1.text = self.activity.contactPhone1;
    self.navigationItem.hidesBackButton = NO;
}
- (IBAction)btnActionAddToFavorites:(id)sender {
    NSDictionary* favoriteDictionary = [[NSDictionary alloc] initWithObjects:@[self.activity.name,self.activity.id,@"0",self.activity.areaId] forKeys:@[@"name",@"activityId",@"categoryId",@"areaId"]];
    [[AppSettings sharedInstance] addFavorite:favoriteDictionary];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Favorito" message:@"Favorito agregado!" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
    [alert show];
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
