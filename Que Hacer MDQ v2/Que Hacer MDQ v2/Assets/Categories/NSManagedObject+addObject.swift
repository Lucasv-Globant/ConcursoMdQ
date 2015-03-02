//
//  NSManagedObject+addObject.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/18/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import CoreData

extension NSManagedObject {
    
    
    //for adding objects to a NSSet relationship
    func addObject(value: NSManagedObject, forKey: String) {
        var items = self.mutableSetValueForKey(forKey);
        items.addObject(value)
    }


}