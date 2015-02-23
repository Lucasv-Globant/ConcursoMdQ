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
    
    @NSManaged var activities: NSSet
    
    //To get a Tag object by its id
    //Returns nil with console error when can't find it or if there is more than 1 result
    class func getTag(tagId: Int) -> Tag? {
        
        var context: NSManagedObjectContext = DataAccessHelper.sharedInstance().managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Tag")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.includesPropertyValues = false  
        fetchRequest.predicate = NSPredicate(format: "id == %d", tagId)
        
        var error: NSError? = nil
        var matches: NSArray = context.executeFetchRequest(fetchRequest, error: &error)!
        
        if (matches.count == 1) {
            return matches[0] as? Tag
        } else if (matches.count > 1){
            NSLog("Error while retrieving unique area, more than one result.")
            NSLog("%@", matches)
        } else {
            NSLog("Couldn't find tag with id = %d", tagId)
        }
        
        return nil
    }
    
}