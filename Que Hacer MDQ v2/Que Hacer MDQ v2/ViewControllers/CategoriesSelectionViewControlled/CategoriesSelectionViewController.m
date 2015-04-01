//
//  CategoriesSelectionViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/27/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "CategoriesSelectionViewController.h"

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
    self.navigationItem.hidesBackButton = YES;
    /*
     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Test" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
     [alert show];
     */
     
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
