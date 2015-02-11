//
//  Schedule.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/11/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import Foundation
import CoreData

@objc(Schedule)
class Schedule: NSManagedObject {

    @NSManaged var id: Int
    @NSManaged var startDate: NSDate
    @NSManaged var endDate: NSDate
    @NSManaged var startTime: NSDate
    @NSManaged var endTime: NSDate
    @NSManaged var dayDescription: String
    
}