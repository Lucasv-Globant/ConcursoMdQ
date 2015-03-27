//
//  ActivityCategory.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/27/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//



#import "ActivityCategory.h"

@implementation ActivityCategory

+(NSArray*)categoriesListing
{
    NSMutableArray* list = [[NSMutableArray alloc] init];
    int i;
    for (i=1; i<=17; i++) {
        [list addObject:[[ActivityCategory alloc] initById:i]];
    }
    return [NSArray arrayWithArray:list];
}



-(ActivityCategory*)initById:(int)categoryId
{
    if (self=[super init])
    {
        self.categoryId = categoryId;
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
                self.imageFileName = @"cat_otros.png";
                self.name = @"Otros";
                break;
        }
        
    }
    
    return self;
}


@end
