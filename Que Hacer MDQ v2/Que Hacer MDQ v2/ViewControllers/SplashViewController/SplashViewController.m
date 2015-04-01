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
    
    //Set the background according to the time of the day:
    [[self background] setImage:[UIImage imageNamed:[self backgroundImageFileNameByTime]]];
    [self startSynchronizing];
    
}

- (void) startSynchronizing
{
    [self.activityIndicator startAnimating];
    NSLog(@"Synchronizing...");
    Synchronizer* sync = [[Synchronizer alloc] init];
    [sync syncWithSuccess:^(NSMutableArray* activitiesArray)
     {
         NSLog(@"Entered synchro success block..");
         [self.activityIndicator stopAnimating];
         
         CategoriesSelectionViewController* csvc = [[CategoriesSelectionViewController alloc] initWithNibName:@"CategoriesSelectionViewController" bundle:nil];
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
    
    int currentHourOfDay = [[DataTypesHelper getHourOfCurrentTime] intValue];
    
    //Sunrise:
    if ((currentHourOfDay >= 5) && (currentHourOfDay <= 7))
    {
        result = @"bg_amanecer1.png";
    }

    //Sunset:
    if ((currentHourOfDay >= 18) && (currentHourOfDay <= 20))
    {
        result = @"bg_atardecer1.png";
    }

    //Night:
    if ((currentHourOfDay > 18) || (currentHourOfDay < 5))
    {
        result = @"bg_noche2.png";
    }

    return result;

}

@end
