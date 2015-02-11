//
//  location.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/11/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import Foundation
import CoreData

@objc(Location)
class Location: NSManagedObject {

    @NSManaged var id: Int
    @NSManaged var latitude: Float
    @NSManaged var longitude: Float
    @NSManaged var streetOrRoute: String
    @NSManaged var HouseNumberingOrKm: String
    @NSManaged var detail: String
    
}

