//
//  Area.swift
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/16/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import Foundation
@objc(Area)

class Area: NSObject {

class func getDescription(areaId: Int) -> NSString?
{
    switch areaId
    {
        case 0 :
            return "Actividades y Eventos"
        case 1 :
            return "Gastronomía"
        default :
            return "Actividades y Eventos"
    }
}
    
    
}
