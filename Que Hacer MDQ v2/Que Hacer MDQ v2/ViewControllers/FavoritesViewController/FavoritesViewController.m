//
//  FavoritesViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/7/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "FavoritesViewController.h"


@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.activities = [self retrieveFavoriteActivities];
    UINib *cellNib = [UINib nibWithNibName:@"FavoritesTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"FavoritesTableViewCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Implementation of protocol: FavoritesTableViewCellDelegate 
-(void)didTapOnGoToFavorite:(NSNumber*)activityId
{
    DetailViewController* dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil] ;
    dvc.activity = [self retrieveActivityWithId:activityId];
    [self.navigationController pushViewController:dvc animated:YES];
}

-(void)didTapOnDeleteFavorite:(NSNumber*)activityId
{
    [[AppSettings sharedInstance] removeFavoriteWithID:[activityId stringValue]];
    [self.tableView reloadData];
}

#pragma mark Activities retrievers (helpers)
-(Activity*)retrieveActivityWithId:(NSNumber*)activityId
{
    //TO DO: retrieve from Core Data the activity with the given ID.
    //For now, we'll return a blank activity
    Activity* result = [[Activity alloc] init];
    return result;
}


-(NSArray*)retrieveFavoriteActivities
{
    //TO DO: Populate favorite activities (use the IDs saved in AppSettings to retrieve the model objects from CoreData)
    //For now, we'll return an empty array
    NSArray* result = [[NSArray alloc] init];
    return result;
}

#pragma mark UITableView Protocol
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavoritesTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"FavoritesTableViewCell" forIndexPath:indexPath];
    cell.activity = [self.activities objectAtIndex:indexPath.row];
    return cell;
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.activities count];
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


