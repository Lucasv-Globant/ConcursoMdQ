//
//  CategoriesSelectionViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/27/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "CategoriesSelectionViewController.h"
#import <UIViewController+MMDrawerController.h>
#import "MMDrawerBarButtonItem.h"
#import "FavoritesViewController.h"
#import "FoodAndDrinkViewController.h"
#import "Theme.h"

@interface CategoriesSelectionViewController ()
@property (nonatomic,strong) NSArray* categories;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;
@property (strong, nonatomic) IBOutlet UILabel *lbl_subtitle;
@property (strong, nonatomic) IBOutlet UIButton *btn_continue;

@end

@implementation CategoriesSelectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.categories = [ActivityCategory categoriesListing];
    
    UINib *cellNib = [UINib nibWithNibName:@"CategoryCollectionViewCell" bundle:nil];

    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
    NSLog(@"%@",self.parentViewController);
    self.mainMenu = (PIMainMenuController *)self.mm_drawerController.leftDrawerViewController;
    self.mainMenu.delegate = self;
    [self configureSideBar];
    self.btn_continue.tintColor = [UIColor whiteColor];
    self.btn_continue.backgroundColor = [Theme colorGreen];
    [self.btn_continue.titleLabel setFont:[Theme fontButton]];
    [self.btn_continue setTitle:@"CONTINUAR" forState:UIControlStateNormal];
    self.btn_continue.layer.cornerRadius = 20;
    [self configNavigationbar];
    [self configLabel];
    
}

-(void)configLabel
{
    [self.lbl_title setText:@"¿Qué cosas te interesan?"];
    self.lbl_title.font = [Theme fontButton01];
    self.lbl_title.font = [UIFont systemFontOfSize:16];
    
    [self.lbl_subtitle setText: @"Seleccioná algunas categorías que te gusten"];
    [self.lbl_subtitle setFont:[Theme fontButton02]];
    self.lbl_subtitle.font = [UIFont systemFontOfSize:12];
}

-(void)configNavigationbar
{
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.barTintColor = [Theme colorPink];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //self.navigationItem.hidesBackButton = YES;
    
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
- (IBAction)btnContinue2:(id)sender {

    //Check if there is **at least** one category selected:
    BOOL selectionMade = NO;
    for (ActivityCategory* category in self.categories) {
        selectionMade = selectionMade || category.isSelected;
    }
    
    if (selectionMade)
    {
        //All OK, at least one category has been selected. Let's move on.
        [ActivityCategory saveSettingsForCategories:[self categories]];
        ActivitiesListViewController* alvc = [[ActivitiesListViewController alloc] initWithNibName:@"ActivitiesListViewController" bundle:nil];
        [self.navigationController pushViewController:alvc animated:YES];
        alvc.categories = self.categories;
    }
    else
    {
        //No category has been selected
        //Present the user with a pop-up alert
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Seleccion" message:@"Debe seleccionar al menos una categoría" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alert show];
    }
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
    FoodAndDrinkViewController* fadvc = [[FoodAndDrinkViewController alloc] initWithNibName:@"FoodAndDrinkViewController" bundle:nil];
    [self.navigationController pushViewController:fadvc animated:YES];
    
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.categories count];
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
    
    ActivityCategory* category = [self.categories objectAtIndex:[indexPath row]];
    
    //Set the text label:
    UILabel* label = (UILabel*)[cell viewWithTag:2];
    label.text = [category name];
    //Set the background:
    UIImageView* background = (UIImageView*)[cell viewWithTag:1];
    background.image = [UIImage imageNamed:[category imageFileName]];
    //Set the checkmark (checked/unchecked):
    UIImageView* check = (UIImageView*)[cell viewWithTag:3];
    check.hidden = !category.isSelected;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //When a cell is tapped, its' "selected" value should be inverted
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    ActivityCategory* category = [self.categories objectAtIndex:[indexPath row]];
    category.isSelected = !category.isSelected;
    UIImageView* check = (UIImageView*)[cell viewWithTag:3];
    check.hidden = !category.isSelected;
    
}

@end
