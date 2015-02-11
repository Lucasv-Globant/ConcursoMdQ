//
//  Tag.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/11/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import Foundation
import CoreData

@objc(Tag)
class Tag: NSManagedObject {

    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var desc: String
    
}