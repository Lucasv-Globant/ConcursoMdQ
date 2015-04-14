//
//  Area.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/14/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "Area.h"

@implementation Area

+(NSString*)getAreaPluralDescriptionById:(NSNumber*)areaId
{

    switch ([areaId intValue])
    {
    case 0 :
        return @"Actividades y Eventos";
        break;
    case 1 :
        return @"Gastronomía";
        break;
    default :
        return @"Actividades y Eventos";
        break;
    }
}


+(NSString*)getAreaSingularDescriptionById:(NSNumber*)areaId
{
    switch ([areaId intValue])
    {
        case 0 :
            return @"Actividad/Evento";
            break;
        case 1 :
            return @"Gastronomía";
            break;
        default :
            return @"Actividad/Evento";
            break;
    }
}

@end
