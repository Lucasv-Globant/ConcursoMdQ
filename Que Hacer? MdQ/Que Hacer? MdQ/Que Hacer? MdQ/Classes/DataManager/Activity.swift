//
//  Activity.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/9/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import Foundation
import CoreData

@objc(Activity)
class Activity: NSManagedObject {
    
    @NSManaged var id: Int
    
    //Relationships:
    @NSManaged var images: NSSet
    @NSManaged var contacts: NSSet
    @NSManaged var feeds: NSSet
    @NSManaged var areas: NSSet
    @NSManaged var tags: NSSet
    @NSManaged var schedule: NSSet
    @NSManaged var location: Location

    //Attributes:
    @NSManaged var name: String
    @NSManaged var desc: String
    @NSManaged var website: String //NSURL
    @NSManaged var usesSchedule: Bool
    @NSManaged var visitingHours: String
    @NSManaged var start: NSDate
    @NSManaged var end: NSDate
    @NSManaged var cost: Float
    @NSManaged var costString: String //In case of no numeric cost specified
    @NSManaged var handicapAccessRamp: Bool
    @NSManaged var handicapRestroom: Bool
    @NSManaged var paidParkingZone: Bool
    @NSManaged var sharingUrl: String
    @NSManaged var visible: Bool
    
    //Inferred by other attributes for simplicity
//    @NSManaged var occurrsOnce: Bool
//    @NSManaged var multipleTags: Bool
//    @NSManaged var idTag: Int  //In case of single tag
//    @NSManaged var usesDateString: Bool
//    @NSManaged var usesTimeString: Bool

}