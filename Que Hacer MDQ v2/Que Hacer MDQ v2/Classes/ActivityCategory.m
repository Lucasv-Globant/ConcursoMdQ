//
//  ActivityCategory.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/27/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ActivityCategory.h"


@implementation ActivityCategory


#pragma mark - Factory method for the list of categories
+(NSArray*)categoriesListing
{
    //Get the dictionary containing the state of all categories (BOOL: selected/not-selected)
    NSDictionary* selectionDictionary = [ActivityCategory getCategoriesSelectionDictionary];
    
    NSMutableArray* list = [[NSMutableArray alloc] init];
    int i;
    for (i=1; i<=17; i++)
    {
        ActivityCategory* category = [[ActivityCategory alloc] initById:i];
        
        
        NSString* keyObject = @(i).stringValue;
        if ([selectionDictionary objectForKey:keyObject] != nil)
        {
            //convert the "isSelected" value stored, from NSNumber to bool
            category.isSelected = [[selectionDictionary objectForKey:keyObject] boolValue];
        }
        else
        {
            //The category does not exist in the dictionary. Defaulting to NO
            category.isSelected = NO;
        }
        
        
        [list addObject:category];
    }
    return [NSArray arrayWithArray:list];
}


#pragma mark - (Internal) Initializer by Category ID
-(ActivityCategory*)initById:(int)categoryId
{
    if (self=[super init])
    {
        self.categoryId = categoryId;
        self.isSelected = NO;
        
        switch (categoryId)
        {
            case 1:
                self.imageFileName= @"art_category_roundbutton_outdoors.png";
                self.name = @"Aire Libre";
                self.tagId = [NSNumber numberWithInt:8];
                break;
            case 2:
                self.imageFileName = @"art_category_roundbutton_art.png";
                self.name = @"Arte y Cultura";
                self.tagId = [NSNumber numberWithInt:20];
                break;
            case 3:
                self.imageFileName = @"art_category_roundbutton_casino.png";
                self.name = @"Casinos y Bingos";
                self.tagId = [NSNumber numberWithInt:16];
                break;
            case 4:
                self.imageFileName = @"art_category_roundbutton_sports.png";
                self.name = @"Actividades Deportivas";
                self.tagId = [NSNumber numberWithInt:9];
                break;
            case 5:
                self.imageFileName = @"art_category_roundbutton_sports.png";
                self.name = @"Espectaculos Deportivos";
                self.tagId = [NSNumber numberWithInt:10];
                break;
            case 6:
                self.imageFileName = @"art_category_roundbutton_outdoors.png";
                self.name = @"Excursiones";
                self.tagId = [NSNumber numberWithInt:19];
                break;
            case 7:
                self.imageFileName = @"art_category_roundbutton_AppLogo.png";
                self.name = @"Exposiciones y Ferias";
                self.tagId = [NSNumber numberWithInt:17];
                break;
            case 8:
                self.imageFileName = @"art_category_roundbutton_party.png";
                self.name = @"Fiestas";
                self.tagId = [NSNumber numberWithInt:18];
                break;
            case 9:
                self.imageFileName = @"art_category_roundbutton_kids.png";
                self.name = @"Infantiles";
                self.tagId = [NSNumber numberWithInt:5];
                break;
            case 10:
                self.imageFileName = @"art_category_roundbutton_books.png";
                self.name = @"Literatura";
                self.tagId = [NSNumber numberWithInt:12];
                break;
            case 11:
                self.imageFileName = @"art_category_roundbutton_nightlife.png";
                self.name = @"Noche";
                self.tagId = [NSNumber numberWithInt:7];
                break;
            case 12:
                self.imageFileName = @"art_category_roundbutton_family.png";
                self.name = @"Para Toda La Familia";
                self.tagId = [NSNumber numberWithInt:6];
                break;
            case 13:
                self.imageFileName = @"art_category_roundbutton_waterpark.png";
                self.name = @"Parques Acuaticos";
                self.tagId = [NSNumber numberWithInt:22];
                break;
            case 14:
                self.imageFileName = @"art_category_roundbutton_AppLogo.png";
                self.name = @"Playas";
                self.tagId = [NSNumber numberWithInt:23];
                break;
            case 15:
                self.imageFileName = @"cart_category_roundbutton_AppLogo.png";
                self.name = @"Recitales";
                self.tagId = [NSNumber numberWithInt:2];
                break;
            case 16:
                self.imageFileName = @"art_category_roundbutton_entertainment-shows.png";
                self.name = @"Teatros";
                self.tagId = [NSNumber numberWithInt:15];
                break;
            default:
                //ID:17 - and any other value than 1..16
                self.imageFileName = @"art_category_roundbutton_AppLogo.png";
                self.name = @"Otros";
                self.tagId = [NSNumber numberWithInt:1];
                break;
        }
        
    }

    return self;
}


#pragma mark - Save to persistence
+(void)saveSettingsForCategories:(NSArray*)categories
{
    //Save the selection setting of each category (selected/not selected) for all settings, as a dictionary
    NSMutableDictionary* categoriesSelectionSettings = [[NSMutableDictionary alloc] init];

    for (ActivityCategory* category in categories)
    {
        [categoriesSelectionSettings setObject:[NSNumber numberWithBool:category.isSelected] forKey:@(category.categoryId).stringValue];
    }


    NSDictionary* immutableDictionary = [[NSDictionary alloc] initWithDictionary:categoriesSelectionSettings];
    [[AppSettings sharedInstance] setCategoriesSelectionDictionary:immutableDictionary];
}


#pragma mark - Retrieve from persistence
+(NSDictionary*)getCategoriesSelectionDictionary
{
    NSDictionary* result = [[AppSettings sharedInstance] getCategoriesSelectionDictionary];
    
    if (!result)
    {
        result = [[NSDictionary alloc] init];
    }
    
    return result;

}


@end
