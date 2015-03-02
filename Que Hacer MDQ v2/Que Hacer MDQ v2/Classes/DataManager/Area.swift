//
//  Area.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/11/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import Foundation
import CoreData


@objc(Area)
class Area: NSManagedObject {

    @NSManaged var id: Int
    @NSManaged var desc: String
    @NSManaged var name: String

    
    
    //To get a Area object by its id
    class func getArea(areaId: Int) -> Area? {
        
        var context: NSManagedObjectContext = DataAccessHelper.sharedInstance().managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Area")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.includesPropertyValues = false
        fetchRequest.predicate = NSPredicate(format: "id == %d", areaId)
        
        var error: NSError? = nil
        var matches: NSArray = context.executeFetchRequest(fetchRequest, error: &error)!
        
        if (matches.count == 1) {
            return matches[0] as? Area
        } else if (matches.count > 1){
            NSLog("%@", matches)
            NSLog("Error while retrieving unique area, more than one result.")
        } else {
            NSLog("Couldn't find area with id = %d", areaId)
        }
        
        return nil
    }
 
    
    
    
    
}