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
                self.imageFileName= @"cat_aireLibre.png";
                self.name = @"Aire Libre";
                break;
            case 2:
                self.imageFileName = @"cat_arteYCultura.png";
                self.name = @"Arte y Cultura";
                break;
            case 3:
                self.imageFileName = @"cat_casinosYBingos.png";
                self.name = @"Casinos y Bingos";
                break;
            case 4:
                self.imageFileName = @"cat_actividadesDeportivas.png";
                self.name = @"Actividades Deportivas";
                break;
            case 5:
                self.imageFileName = @"cat_espectaculosDeportivos.png";
                self.name = @"Espectaculos Deportivos";
                break;
            case 6:
                self.imageFileName = @"cat_excursiones.png";
                self.name = @"Excursiones";
                break;
            case 7:
                self.imageFileName = @"cat_exposicionesYFerias.png";
                self.name = @"Exposiciones y Ferias";
                break;
            case 8:
                self.imageFileName = @"cat_fiestas.png";
                self.name = @"Fiestas";
                break;
            case 9:
                self.imageFileName = @"cat_infantiles.png";
                self.name = @"Infantiles";
                break;
            case 10:
                self.imageFileName = @"cat_literatura.png";
                self.name = @"Literatura";
                break;
            case 11:
                self.imageFileName = @"cat_noche.png";
                self.name = @"Noche";
                break;
            case 12:
                self.imageFileName = @"cat_paraTodaLaFamilia.png";
                self.name = @"Para Toda La Familia";
                break;
            case 13:
                self.imageFileName = @"cat_parquesAcuaticos.png";
                self.name = @"Parques Acuaticos";
                break;
            case 14:
                self.imageFileName = @"cat_playas.png";
                self.name = @"Playas";
                break;
            case 15:
                self.imageFileName = @"cat_recitales.png";
                self.name = @"Recitales";
                break;
            case 16:
                self.imageFileName = @"cat_teatros.png";
                self.name = @"Teatros";
                break;
            default:
                //ID:17 - and any other value than 1..16
                self.imageFileName = @"cat_otros.png";
                self.name = @"Otros";
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
