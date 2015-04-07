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

@interface CategoriesSelectionViewController ()
@property (nonatomic,strong) NSArray* categories;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CategoriesSelectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.categories = [ActivityCategory categoriesListing];
    
    UINib *cellNib = [UINib nibWithNibName:@"CategoryCollectionViewCell" bundle:nil];

    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
 //   self.navigationItem.hidesBackButton = YES;
    NSLog(@"%@",self.parentViewController);
    self.mainMenu = (PIMainMenuController *)self.mm_drawerController.leftDrawerViewController;
    self.mainMenu.delegate = self;
    [self configureSideBar];
     
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
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.translucent = NO;
    } else {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    
    [self configureLeftBarButton];
    
    
    self.mm_drawerController.isAccessibilityElement = YES;
    self.mm_drawerController.maximumLeftDrawerWidth = 270;
    self.mm_drawerController.maximumRightDrawerWidth = 270;
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeCustom;
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView;
    
}

- (void)configureLeftBarButton {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *leftButtonImage = [UIImage imageNamed:@"menu"];
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

-(void)didSelectSearch {}

-(void)didSelectInteres {}

-(void)didSelectAllEvent {}

-(void)didSelectFavorite {}

-(void)didSelectGastronomia {}



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
