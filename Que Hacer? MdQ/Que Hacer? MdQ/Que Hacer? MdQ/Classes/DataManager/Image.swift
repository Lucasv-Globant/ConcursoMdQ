//
//  Images.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/11/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import Foundation
import CoreData

@objc(Image)
class Image: NSManagedObject {

    @NSManaged var id: Int
    @NSManaged var desc: String
    @NSManaged var url: String //NSURL
    
}