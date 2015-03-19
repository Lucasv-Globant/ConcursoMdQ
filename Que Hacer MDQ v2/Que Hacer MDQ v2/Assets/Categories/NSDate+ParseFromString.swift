//
//  NSDate+ParseFromString.swift
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/9/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

import Foundation

extension NSDate
{
    convenience
    
    //Initialize from string in format yyyyMMdd
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyyMMdd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "es_AR")
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    
    
}

