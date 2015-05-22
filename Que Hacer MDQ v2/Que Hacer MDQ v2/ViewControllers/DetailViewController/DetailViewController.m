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

@property (strong, nonatomic) IBOutlet UITextView *textViewActivityTime;
@property (strong, nonatomic) IBOutlet UILabel *labelActivityPhone1;

@property (strong, nonatomic) IBOutlet UITextView *textViewActivityDetails;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnAddToFavorites.layer.cornerRadius = 10;
    self.btnShare.layer.cornerRadius = 10;
    self.btnGoToMap.layer.cornerRadius = 10;
    
    // Do any additional setup after loading the view from its nib.
    self.labelActivityName.text = self.activity.name;
    self.labelActivityLocation1.text = self.activity.locationDetails;
    NSString* locationString;
    if ([self.activity.locationStreetOrRoute rangeOfString:@"Ruta"].length > 0 || [self.activity.locationStreetOrRoute rangeOfString:@"Autovía"].length > 0 )
    {
        locationString = [NSString stringWithFormat:@"%@ Km.%@",self.activity.locationStreetOrRoute,self.activity.locationHouseNumberingOrKm];
    }
    else
    {
        locationString = [NSString stringWithFormat:@"%@ %@",self.activity.locationStreetOrRoute,self.activity.locationHouseNumberingOrKm];
    }
    self.labelActivityLocation2.text = locationString;
    self.textViewActivityTime.text = self.activity.visitingHoursString;
    self.textViewActivityDetails.text = self.activity.desc;
    self.labelActivityPhone1.text = self.activity.contactPhone1;
    self.navigationItem.hidesBackButton = NO;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnAddTofavorites:(id)sender
{
    NSDictionary* favoriteDictionary = [[NSDictionary alloc] initWithObjects:@[self.activity.name,self.activity.activityId,@"0",self.activity.areaId] forKeys:@[@"name",@"activityId",@"categoryId",@"areaId"]];
    [[AppSettings sharedInstance] addFavorite:favoriteDictionary];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Favorito" message:@"Favorito agregado!" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
    [alert show];
}
- (IBAction)btnGoToMap:(id)sender {
    MapViewController* mvc = [[MapViewController alloc] init];
    mvc.activity = self.activity;
    //[mvc setupforSingleActivity:self.activity];
    [self.navigationController pushViewController:mvc animated:YES];
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
