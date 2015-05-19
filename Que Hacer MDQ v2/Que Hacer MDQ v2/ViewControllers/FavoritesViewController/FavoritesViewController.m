//
//  FavoritesViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/7/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "FavoritesViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "MMDrawerBarButtonItem.h"
#import "FoodAndDrinkViewController.h"
#import "SearchActivityViewController.h"
#import "CategoriesSelectionViewController.h"


@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.activities = [self retrieveFavoriteActivities];
    UINib *cellNib = [UINib nibWithNibName:@"FavoritesTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"FavoritesTableViewCell"];
    
    self.mainMenu = (PIMainMenuController *)self.mm_drawerController.leftDrawerViewController;
    self.mainMenu.delegate = self;
    [self configureSideBar];

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
    //Remove from NSUserDefaults...
    [[AppSettings sharedInstance] removeFavoriteWithID:[activityId stringValue]];
    
    //Creating a temporary (mutable) array to add all items except the deleted one
    NSMutableArray* mutableFavorites = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in self.activities)
    {
        //Add all favorites to the temp array, except the one that was deleted
        if ([dict objectForKey:@"activityId"] != activityId)
        {
            [mutableFavorites addObject:dict];
        }
    }
    
    //Replace the activities array used by the table
    self.activities = [[NSArray alloc] initWithArray:mutableFavorites];
    
    

    
    
    //Reload the table view
    [self.tableView reloadData];
}

#pragma mark Activities retrievers (helpers)
//Gets a specific activity from persistence
-(Activity*)retrieveActivityWithId:(NSNumber*)activityId
{
    Activity* result = [[CoreDataHelper sharedInstance] getActivityWithId:activityId];
    if (!result)
    {
        NSLog(@"WARNING: FavoritesViewController->retrieveActivityWithId:%@ returned Nil",activityId);
    }
    return result;
}

//Returns a NSArray containing NSDictionaries with all the favorite activities
-(NSArray*)retrieveFavoriteActivities
{
    NSDictionary* appSettingsFavorites = [[AppSettings sharedInstance] getFavoritesDictionary];
    
    NSMutableArray* favoritesMutableArray = [[NSMutableArray alloc] init];
    for (NSString* key in appSettingsFavorites)
    {
        [favoritesMutableArray addObject:[appSettingsFavorites objectForKey:key]];
    }
    
    return [NSArray arrayWithArray:favoritesMutableArray];
}

#pragma mark UITableView Protocol
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavoritesTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"FavoritesTableViewCell" forIndexPath:indexPath];
    [cell populateCellWithDictionary:[self.activities objectAtIndex:indexPath.row]];
    cell.delegate = self;
    return cell;
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.activities count] == 0)
    {
        self.lblNoFavorites.hidden = NO;
        //self.tableView.hidden = YES;
    }
    else
    {
        self.lblNoFavorites.hidden = YES;
        //self.tableView.hidden = NO;
    }
    return [self.activities count];
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
}

-(void)didSelectGastronomia {
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    FoodAndDrinkViewController* fadvc = [[FoodAndDrinkViewController alloc] initWithNibName:NIB_NAME_VC_FOODANDDRINK_LIST bundle:nil];
    [self.navigationController pushViewController:fadvc animated:YES];
    
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


