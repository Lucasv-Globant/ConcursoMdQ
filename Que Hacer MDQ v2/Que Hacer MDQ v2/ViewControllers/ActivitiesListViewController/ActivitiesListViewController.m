//
//  ActivitiesListViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/25/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ActivitiesListViewController.h"
#import "ActivitiesListTableViewCell.h"
#import <UIViewController+MMDrawerController.h>
#import "MMDrawerBarButtonItem.h"
#import "DataTypesHelper.h"
#import "DetailViewController.h"
#import "UILabel+AutoHeight.h"
#import "Theme.h"
#import "FoodAndDrinkDetailViewController.h"
#import "CategoriesIconCollectionViewCell.h"
#import "ActivitiesCollection.h"

#define CATEGORY_ICON_COLLECTION_VIEW_CELL @"CategoriesIconCollectionViewCell"


@interface ActivitiesListViewController ()

@property (nonatomic, strong) NSArray* activities;//The activities filtered by selected category
@property (assign, nonatomic) NSArray* allActivities;//All activities from Core Data (no filtering)
@property (strong, nonatomic) IBOutlet UITableView *activitiesUITableView;
@property (strong, nonatomic) IBOutlet UIImageView *activitiesUIImageView;
@property (assign, nonatomic) NSInteger indexPathSelect;

@end

@implementation ActivitiesListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.categories = [ActivityCategory getSelectedCategories];
    
    self.indexPathSelect = 0; //Set the first item from the collection as the one selected
    
    [self filterActivitiesBySelectedCategory];

    for (Activity* act in self.activities) {
        NSLog(@"Activity name: %@",act.name);
        for (Tag* someTag in act.tags) {
            NSLog(someTag.name,nil);
        }
    }
    
    UINib *cellNib = [UINib nibWithNibName:@"ActivitiesListTableViewCell" bundle:nil];
    
    [self.activitiesUITableView registerNib:cellNib forCellReuseIdentifier:@"ActivitiesListTableViewCell"];

    UINib *collectionViewCellNib = [UINib nibWithNibName:CATEGORY_ICON_COLLECTION_VIEW_CELL bundle:nil];
    
    self.categoriesMenu.backgroundColor = [UIColor whiteColor];
    [self.categoriesMenu registerNib:collectionViewCellNib forCellWithReuseIdentifier:CATEGORY_ICON_COLLECTION_VIEW_CELL];
    [self configureSideBar];
    [self confingNavigationbar];
  
}

-(void)retrieveAllActivitiesFromCoreData
{
    //NSString* predicateString = [NSString stringWithFormat:@"tags.id == %@",categoryTagId];
    //NSString* predicateString = [NSString stringWithFormat:@"tags.name == 1"];
    //NSString* predicateString = [NSString stringWithFormat:@"tags.name = 'General'"];
    NSString* predicateString = [NSString stringWithFormat:@"areaId = 1"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateString];
    self.allActivities = [[CoreDataHelper sharedInstance] fetchEntitiesForClass:[Activity class] withPredicate:predicate inManagedObjectContext:[[CoreDataHelper sharedInstance] managedObjectContext]];
}

-(void)viewWillAppear:(BOOL)animated
{
   [self.activitiesUITableView reloadData];
}


-(void)filterActivitiesBySelectedCategory
{
    //This method filters the activities with the tagId of the selected category
    //It filters the "self.allActivities" array (which contains ALL objects) and assigns an array of filtered results to self.activities
    
    //Get all activities (unfiltered) from Core Data
    [self retrieveAllActivitiesFromCoreData];
    
    //Calculate which category has been selected
    ActivityCategory* category = [self.categories objectAtIndex:self.indexPathSelect];
    
    //Obtain the equivalent tagId of the selected category
    NSNumber* categoryTagId = category.tagId;
   
    //Use a "collection of activities" in order to filter items easily
    ActivitiesCollection* collection = [[ActivitiesCollection alloc] initWithArray:self.allActivities];
    self.activities = [collection filterActivitiesWithTagIds:[NSArray arrayWithObject:categoryTagId]];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.categories count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CATEGORY_ICON_COLLECTION_VIEW_CELL forIndexPath:indexPath];
    
    ActivityCategory* category = [self.categories objectAtIndex:[indexPath row]];
    
    //Set the icon:
    UIImageView* icon = (UIImageView*)[cell viewWithTag:1];
    icon.image = [UIImage imageNamed:[category imageFileName]];
    
    
    UIImageView* check = (UIImageView*)[cell viewWithTag:2];
    if (indexPath.row == self.indexPathSelect)
    {
       check.hidden = NO;
       self.activitiesUIImageView.image = [UIImage imageNamed: category.imageOriginFileName];
    }
    else
    {
        check.hidden = YES;
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //When a cell is tapped, its' "selected" value should be inverted
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    ActivityCategory* category = [self.categories objectAtIndex:[indexPath row]];
    self.indexPathSelect = indexPath.row ;
    UIImageView* check = (UIImageView*)[cell viewWithTag:2];
    
    if (check.hidden)
    {
        [self filterActivitiesBySelectedCategory];
        check.hidden = NO;
        [self.categoriesMenu reloadData];
        [self.activitiesUITableView reloadData];
    }
   self.activitiesUIImageView.image = [UIImage imageNamed: category.imageOriginFileName];
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
    if ([activity.locationStreetOrRoute rangeOfString:@"Ruta"].length > 0 || [activity.locationStreetOrRoute rangeOfString:@"Autovía"].length > 0 )
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
    DetailViewController* dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    dvc.activity = selectedActivity;
    [self.navigationController pushViewController:dvc animated:YES];
}


- (void)configureSideBar {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.view.frame = screenRect;
    
    [self configureLeftBarButton];
    
}

-(void)confingNavigationbar
{
    
    CGRect frame = CGRectMake(0,0,200,44);
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:frame];
    UIView* view =[[UIView alloc]initWithFrame:frame];
    titlelabel.font = [Theme fontButton];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.textColor = [UIColor whiteColor];;
    titlelabel.text = @"Intereses";
    [view addSubview:titlelabel];
    self.navigationItem.titleView = view;
}

- (void)configureLeftBarButton {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *leftButtonImage = [UIImage imageNamed:@"menu"];
    leftButton.backgroundColor = [UIColor clearColor];
    leftButton.frame = CGRectMake(0, 0, 40, 40);
    leftButton.contentMode = UIViewContentModeBottomLeft;
    
    [leftButton setImage:leftButtonImage forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(didSelectMainMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *leftButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton2.frame = CGRectMake(0, 0, 15, 40);
    leftButton2.contentMode = UIViewContentModeBottomLeft;
    [leftButton2 setBackgroundColor:[UIColor clearColor]];
    [leftButton2 addTarget:self action:@selector(didSelectMainMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    MMDrawerBarButtonItem *xxx = [[MMDrawerBarButtonItem alloc] initWithCustomView:leftButton2];
    
    [self.navigationItem setLeftBarButtonItems:@[[self spacer], leftDrawerButton, xxx]];
}

- (void)didSelectMainMenu:(id)sender {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (UIBarButtonItem *)spacer {
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -11;
    return space;
}

-(void)didSelectSearch {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

-(void)didSelectInteres {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

-(void)didSelectAllEvent {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

-(void)didSelectFavorite {
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    
    //FavoritesViewController* fvc = [[AppMain sharedInstance] sharedFavoritesViewController];
    //self.navigationController.viewControllers = @[fvc];
    
    FavoritesViewController* fvc = [[FavoritesViewController alloc] initWithNibName:@"FavoritesViewController" bundle:nil];
    [self.navigationController pushViewController:fvc animated:YES];
    
}

-(void)didSelectGastronomia {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    FoodAndDrinkDetailViewController* fadvc = [[FoodAndDrinkDetailViewController alloc] initWithNibName:@"FoodAndDrinkViewController" bundle:nil];
    [self.navigationController pushViewController:fadvc animated:YES];
    
}


@end
