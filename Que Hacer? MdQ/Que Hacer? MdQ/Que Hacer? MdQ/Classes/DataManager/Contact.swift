//
//  Contact.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/11/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import Foundation
import CoreData

@objc(Contact)
class Contact: NSManagedObject {

    @NSManaged var id: Int
    @NSManaged var desc: String
    @NSManaged var phoneNumber: String
    
}
