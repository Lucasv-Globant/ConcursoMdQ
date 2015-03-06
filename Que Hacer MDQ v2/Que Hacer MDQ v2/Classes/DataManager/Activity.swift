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
    @NSManaged var feeds: NSSet
    @NSManaged var area: Area
    @NSManaged var tags: NSSet
    @NSManaged var schedules: NSSet

    //Atributes
    @NSManaged var locationLatitude: Float
    @NSManaged var locationLongitude: Float
    @NSManaged var locationStreetOrRoute: String
    @NSManaged var locationHouseNumberingOrKm: String
    @NSManaged var locationDetails: String  //in case of no specific data of street and number
    @NSManaged var contactPhone1: String
    @NSManaged var contactPhone2: String
    @NSManaged var contactPhone3: String
    @NSManaged var photoUrl1: String
    @NSManaged var photoUrl2: String
    @NSManaged var photoUrl3: String
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
    @NSManaged var createdAt: NSDate
    @NSManaged var updatedAt: NSDate
    
    
    //Inferred by other attributes for simplicity
//    @NSManaged var usesDateString: Bool
//    @NSManaged var usesTimeString: Bool
    
    
    
    //Returns true if the activity has more than one tag
    func hasMultipleTags() -> Bool {
        
        if self.tags.count > 1 {
            return true
        } else {
            return false
        }
    
    }
    
    //If the activity has only one tag it returns it, otherwise returns nil (with console error).
    func getSingleTag() -> Tag? {
        
        if self.hasMultipleTags() {
            NSLog("Activitie with more than 1 tag, cannot retrieve single tag.")
            return nil
        } else {
            return self.tags.allObjects[0] as? Tag
        }
        
    }
    
    
//    func occurrsOnce() -> Bool {
//        
//        return false
//    }
    
    
    //returns true if delete all was succesfull
    class func deleteAllActivities() -> Bool {
        
        var context: NSManagedObjectContext = DataAccessHelper.sharedInstance().managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Activity")
        
        fetchRequest.includesPropertyValues = false
        
        var error: NSError? = nil
        var matches: NSArray = context.executeFetchRequest(fetchRequest, error: &error)!
        
        if (error != nil) {
            NSLog("Error in fetching AllActivities for delete in method deleteAllActivities.");
            return false;
        }
        
        for activity in matches {
            context.deleteObject(activity as NSManagedObject)
        }
        
        var saveError: NSError? = nil
        if !context.save(&saveError) {
            
            NSLog("Error, couldn't delete: %@", saveError!.localizedDescription)
            context.rollback()
            
            return false
        }
        
        return true
    }
    
    //Activities With Predicate
    class func getAllActivities(predicate: NSPredicate!) -> NSArray? {
        
        var context: NSManagedObjectContext = DataAccessHelper.sharedInstance().managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Activity")
        
        //fetchRequest.includesPropertyValues = false
        fetchRequest.predicate = predicate
        
        var error: NSError? = nil
        var matches: NSArray = context.executeFetchRequest(fetchRequest, error: &error)!
        
        if (error != nil) && (matches.count > 0) {
            return matches
        } else {
            NSLog("Error while retrieving activities: %@", error!.localizedDescription)
            return nil
        }
        
    }
    /*
    //Activities With Sort Descriptor
    class func getAllActivities(sortDescriptor: NSSortDescriptor?) -> NSArray? {
        //optional sortDescriptor
        
        var context: NSManagedObjectContext = DataAccessHelper.sharedInstance().managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Activity")
        
        //fetchRequest.includesPropertyValues = false
        if sortDescriptor != nil {
            fetchRequest.sortDescriptors = [sortDescriptor!]
        }
        
        var error: NSError? = nil
        var matches: NSArray = context.executeFetchRequest(fetchRequest, error: &error)!
        
        if (error != nil) && (matches.count > 0) {
            return matches
        } else {
            NSLog("Error while retrieving activities: %@", error!.localizedDescription)
            return nil
        }
        
    }
    */
    func initWithDictionary(dic: NSDictionary) -> Activity {
        //NOT FINISHED
        
        var context: NSManagedObjectContext = DataAccessHelper.sharedInstance().managedObjectContext
        let newActivity = NSEntityDescription.insertNewObjectForEntityForName("Activity",
            inManagedObjectContext: context) as Activity
        
        newActivity.id = dic.objectForKey("activityid") as Int
        newActivity.name = dic.objectForKey("name") as String
        newActivity.desc = dic.objectForKey("description") as String
        
        newActivity.contactPhone1 = dic.objectForKey("contactPhone1") as String
        newActivity.contactPhone2 = dic.objectForKey("contactPhone2") as String
        newActivity.contactPhone3 = dic.objectForKey("contactPhone3") as String
        
        newActivity.photoUrl1 = dic.objectForKey("photoUrl1") as String
        newActivity.photoUrl2 = dic.objectForKey("photoUrl2") as String
        newActivity.photoUrl3 = dic.objectForKey("photoUrl3") as String
        
        newActivity.locationStreetOrRoute = dic.objectForKey("locationStreetOrRoute") as String
        newActivity.locationHouseNumberingOrKm = dic.objectForKey("locationHouseNumberingOrKm") as String
        newActivity.locationDetails = dic.objectForKey("locationDetails") as String
        newActivity.locationLatitude = dic.objectForKey("locationLatitude") as Float
        newActivity.locationLongitude = dic.objectForKey("locationLongitude") as Float
        
        newActivity.website = dic.objectForKey("website") as String
        newActivity.usesSchedule = dic.objectForKey("usesSchedule") as Bool
        newActivity.visitingHours = dic.objectForKey("visitingHours") as String
        
        newActivity.start = dic.objectForKey("start") as NSDate
        newActivity.end = dic.objectForKey("end") as NSDate
        
        newActivity.cost = dic.objectForKey("cost") as Float
        newActivity.costString = dic.objectForKey("costString") as String
        
        newActivity.handicapAccessRamp = dic.objectForKey("handicapAccessRamp") as Bool
        newActivity.handicapRestroom = dic.objectForKey("handicapRestroom") as Bool
        
        newActivity.paidParkingZone = dic.objectForKey("paidParkingZone") as Bool
        newActivity.sharingUrl = dic.objectForKey("sharingUrl") as String
        
        newActivity.visible = dic.objectForKey("visible") as Bool
        newActivity.createdAt = dic.objectForKey("createdAt") as NSDate
        newActivity.updatedAt = dic.objectForKey("updatedAt") as NSDate
        
        //Relationships:
        newActivity.area = Area.getArea(dic.objectForKey("areaId") as Int)!
        
        if let tags = dic["tags"] as? [[String:String]] {
            for tag in tags {
                
                var tagId: Int = tag["tagId"]!.toInt()!
                var auxTag: Tag = Tag.getTag(tagId)!
                newActivity.addObject(auxTag, forKey: "tags")
            }
        } else {
            NSLog("Error trying to parse the tags for the activity.")
        }
        
        if let schedules = dic["schedules"] as? [[String:String]] {
            for dicSchedule in schedules {
                
                let newSchedule = NSEntityDescription.insertNewObjectForEntityForName("Schedule",
                                                    inManagedObjectContext: context) as Schedule
                
                newSchedule.startDate = NSDate(dateString: dicSchedule["dateStringStart"]!)
                newSchedule.endDate = NSDate(dateString: dicSchedule["dateStringEnd"]!)
                //newSchedule.startTime = NSDate(dateString: dicSchedule["timeStringStart"]!)
                //newSchedule.endTime = NSDate(dateString: dicSchedule["timeStringStart"]!)
                
                newActivity.addObject(newSchedule, forKey: "schedules")
            }
        } else {
            NSLog("Error trying to parse the schedule for the activity.")
        }
        
        return newActivity
    }
    

}




