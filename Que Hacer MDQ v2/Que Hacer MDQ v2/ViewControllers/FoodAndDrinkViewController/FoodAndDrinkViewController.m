//
//  FoodAndDrinkViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/10/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "FoodAndDrinkViewController.h"
#import "ActivitiesListTableViewCell.h"
#import "DataTypesHelper.h"
//#import "DetailViewController.h"
#import "UILabel+AutoHeight.h"
#import "FoodAndDrinkDetailViewController.h"

@interface FoodAndDrinkViewController ()
@property (strong, nonatomic) IBOutlet UITableView *activitiesUITableView;
@property (nonatomic, strong) NSArray* activities;
@end

@implementation FoodAndDrinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"areaId = 2"];
    self.activities = [[CoreDataHelper sharedInstance] fetchEntitiesForClass:[Activity class] withPredicate:predicate inManagedObjectContext:[[CoreDataHelper sharedInstance] managedObjectContext]];
    for (Activity* act in self.activities) {
        NSLog(@"Activity name: %@",act.name);
    }
    
    UINib *cellNib = [UINib nibWithNibName:@"ActivitiesListTableViewCell" bundle:nil];
    
    [self.activitiesUITableView registerNib:cellNib forCellReuseIdentifier:@"ActivitiesListTableViewCell"];
    
    [self.activitiesUITableView reloadData];

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.activities count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Activity* activity = [self.activities objectAtIndex:indexPath.row];
    ActivitiesListTableViewCell* cell = [self.activitiesUITableView dequeueReusableCellWithIdentifier:@"ActivitiesListTableViewCell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        ActivitiesListTableViewCell *cell = [[ActivitiesListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivitiesListTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    //Set the labels. Remove return carriage and truncate:
    cell.labelActivityName.text = [DataTypesHelper removeReturnCarriageFromString:[DataTypesHelper truncateString:activity.name withLength:25]];
    cell.labelActivityDescription.text = [DataTypesHelper removeReturnCarriageFromString:[DataTypesHelper truncateString:activity.desc withLength:25]];
    
    NSString* locationString;
    if ([activity.locationStreetOrRoute containsString:@"Ruta"] || [activity.locationStreetOrRoute containsString:@"Autovía"])
    {
        locationString = [NSString stringWithFormat:@"%@ Km.%@",activity.locationStreetOrRoute,activity.locationHouseNumberingOrKm];
    }
    else
    {
        locationString = [NSString stringWithFormat:@"%@ %@",activity.locationStreetOrRoute,activity.locationHouseNumberingOrKm];
    }
    
    cell.labelActivityLocation.text = [DataTypesHelper removeReturnCarriageFromString:[DataTypesHelper truncateString:locationString withLength:25]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Identify the activity selected, create a detail view controller, and pass the activity to it.
    Activity* selectedActivity = [self.activities objectAtIndex:indexPath.row];
    FoodAndDrinkDetailViewController* fdvc = [[FoodAndDrinkDetailViewController alloc] initWithNibName:@"FoodAndDrinkDetailViewController" bundle:nil];
    fdvc.activity = selectedActivity;
    [self.navigationController pushViewController:fdvc animated:YES];
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
