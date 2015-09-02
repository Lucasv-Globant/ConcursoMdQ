//
//  FoodAndDrinkViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/10/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "FoodAndDrinkViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "ActivitiesListTableViewCell.h"
#import "MMDrawerBarButtonItem.h"
#import "DataTypesHelper.h"
#import "UILabel+AutoHeight.h"
#import "FoodAndDrinkDetailViewController.h"
#import "SearchActivityViewController.h"
#import "CategoriesSelectionViewController.h"

@interface FoodAndDrinkViewController ()
@property (strong, nonatomic) IBOutlet UITableView *activitiesUITableView;
@property (nonatomic, strong) NSArray* activities;
@end

@implementation FoodAndDrinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"areaId = 2"];
    //Debugging: setting nil for predicate
    self.activities = [[CoreDataHelper sharedInstance] fetchEntitiesForClass:[Activity class] withPredicate:nil inManagedObjectContext:[[CoreDataHelper sharedInstance] managedObjectContext]];
    for (Activity* act in self.activities) {
        NSLog(@"Activity name: %@",act.name);
    }
    
    UINib *cellNib = [UINib nibWithNibName:@"ActivitiesListTableViewCell" bundle:nil];
    
    [self.activitiesUITableView registerNib:cellNib forCellReuseIdentifier:@"ActivitiesListTableViewCell"];

    self.mainMenu = (PIMainMenuController *)self.mm_drawerController.leftDrawerViewController;
    self.mainMenu.delegate = self;
    [self configureSideBar];

}



-(void)viewWillAppear:(BOOL)animated
{
    [self.foodAndDrinkUITableView reloadData];
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
    FoodAndDrinkDetailViewController* fdvc = [[FoodAndDrinkDetailViewController alloc] initWithNibName:@"FoodAndDrinkDetailViewController" bundle:nil];
    fdvc.activity = selectedActivity;
    [self.navigationController pushViewController:fdvc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configureSideBar {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.view.frame = screenRect;
    
    [self configureLeftBarButton];
    
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
    SearchActivityViewController* sadvc = [[SearchActivityViewController alloc] initWithNibName:NIB_NAME_VC_SEARCH bundle:nil];
    [self.navigationController pushViewController:sadvc animated:YES];
}

-(void)didSelectInteres {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    CategoriesSelectionViewController* csvc = [[CategoriesSelectionViewController alloc] initWithNibName:NIB_NAME_VC_CATEGORIES_SELECTION bundle:nil];
    [self.navigationController pushViewController:csvc animated:YES];
}

-(void)didSelectAllEvent {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}

-(void)didSelectFavorite {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    FavoritesViewController* fvc = [[FavoritesViewController alloc] initWithNibName:NIB_NAME_VC_FAVORITES bundle:nil];
    [self.navigationController pushViewController:fvc animated:YES];
}

-(void)didSelectGastronomia {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
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
