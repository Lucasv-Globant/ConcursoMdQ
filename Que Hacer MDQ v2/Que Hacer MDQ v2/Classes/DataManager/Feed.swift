//
//  Feed.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/11/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import Foundation
import CoreData

@objc(Feed)
class Feed: NSManagedObject {

    @NSManaged var id: Int
    @NSManaged var desc: String
    @NSManaged var name: String
    @NSManaged var entryPoint: String
    @NSManaged var url: String //NSURL
    
}