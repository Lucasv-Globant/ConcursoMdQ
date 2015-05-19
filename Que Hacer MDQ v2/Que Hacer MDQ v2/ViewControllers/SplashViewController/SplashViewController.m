//
//  SplashViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/26/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "SplashViewController.h"


@interface SplashViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *background;

@end

@implementation SplashViewController
- (IBAction)btnTest:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Test" delegate:self cancelButtonTitle:@"Test" otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = YES;
    //Set the background according to the time of the day:
    [[self background] setImage:[UIImage imageNamed:[self backgroundImageFileNameByTime]]];
    if ([[AppSettings sharedInstance] shouldSynchronize])
         {
             [self startSynchronizing];
         }
        else
        {
            CategoriesSelectionViewController* csvc = [[AppMain sharedInstance] sharedCategoriesSelectionViewController];
            [self.navigationController pushViewController:csvc animated:YES];
        }
    
    
}

- (void) startSynchronizing
{
    [self.activityIndicator startAnimating];
    NSLog(@"Synchronizing...");
    Synchronizer* sync = [[Synchronizer alloc] init];
    [sync syncWithSuccess:^(NSMutableArray* activitiesArray)
     {
         NSLog(@"Entered synchro success block..");
         [[AppSettings sharedInstance] synchronizationDoneSuccessfully];
         [self.activityIndicator stopAnimating];
         
         /*
         CategoriesSelectionViewController* csvc = [[CategoriesSelectionViewController alloc] initWithNibName:@"CategoriesSelectionViewController" bundle:nil];
          */
         CategoriesSelectionViewController* csvc = [[AppMain sharedInstance] sharedCategoriesSelectionViewController];
         [self.navigationController pushViewController:csvc animated:YES];
     }
                  failure:^(NSError* error)
     {
         NSLog(@"Entered synchro error block..");
         UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Ocurrio un error: %@",[error localizedDescription]] delegate:self cancelButtonTitle:@"Reintentar" otherButtonTitles:nil];
         [alert show];
     }];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self startSynchronizing];
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



//Returns the name of the image name, according to the time of the day
//examples: a picture of a sunrise if it's 5AM to 7AM, a picture of a sunset if it's 6PM to 8PM, etc.
-(NSString*)backgroundImageFileNameByTime
{
    //Default return value (morning,afternoon):
    NSString* result = @"bg_soleado1.png";
    
    //Get the hour part of the current time (example= 4 for 4:27PM)
    int currentHourOfDay = [[DataTypesHelper getHourOfCurrentTime] intValue];
    
    //Are we around the summer? Or around the winter?
    int monthOfCurrentDate = (int)[DataTypesHelper getMonthOfCurrentDate];
    
    BOOL theWinterIsComing = YES; //yeah, this is some games of thrones shit
    
    //If we are in between October and March, it's summer time (or close)
    if (monthOfCurrentDate > 9 || monthOfCurrentDate < 4)
    {
        theWinterIsComing = NO;
    }
    
    //Establish the sunset and sunrise times
    int sunriseStartHour24hsFormat;//Sunrise start hour in 24hs format. Example= 6 for 6:00AM
    int sunsetStartHour24hsFormat;//Sunset start hour in 24hs format. Example= 18 for 6:00PM
    
    if (theWinterIsComing)
    {
        //If it's winter, the day light window is a bit narrower than the summer
        sunriseStartHour24hsFormat=7;
        sunsetStartHour24hsFormat=18;
    }
    else
    {
        //If it's summer, we have a broader day light window
        sunriseStartHour24hsFormat=5;
        sunsetStartHour24hsFormat=20;
    }
    
    //Sunrise:
    if ((currentHourOfDay >= sunsetStartHour24hsFormat) && (currentHourOfDay <= sunsetStartHour24hsFormat + 2))
    {
        result = @"bg_amanecer1.png";
    }

    //Sunset:
    if ((currentHourOfDay >= sunsetStartHour24hsFormat) && (currentHourOfDay <= sunsetStartHour24hsFormat + 1))
    {
        result = @"bg_atardecer1.png";
    }

    //Night:
    if ((currentHourOfDay > sunsetStartHour24hsFormat + 1) || (currentHourOfDay < sunriseStartHour24hsFormat))
    {
        result = @"bg_noche2.png";
    }

    return result;

}

@end
