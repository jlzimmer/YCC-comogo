//
//  Event+CoreDataClass.swift
//  YCC-comogo
//
//  Created by James Jung on 12/1/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Event)
public class Event: NSManagedObject {
    var eventStartDate: Date? {
        get {
            return eventStart as Date?
        }
        set {
            eventStart = newValue as NSDate?
        }
    }
    var eventEndDate: Date? {
        get {
            return eventEnd as Date?
        }
        set {
            eventEnd = newValue as NSDate?
        }
    }
    var postedDate: Date? {
        get {
            return datePosted as Date?
        }
        set {
            datePosted = newValue as NSDate?
        }
    }
    
    convenience init?(title:String,eventDescription:String,eventStartDate:Date,eventEndDate:Date,category:String,location:String,postedDate:Date,acceptedStatus:String,id:String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate //on startup from a new phone, this can throw an error. but its super inconsistent.
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        self.init(entity: Event.entity(), insertInto: managedContext)
        
        self.title = title
        self.eventDescription = eventDescription
        self.eventStartDate = eventStartDate
        self.eventEndDate = eventEndDate
        self.category = category
        self.location = location
        self.postedDate = postedDate
        self.acceptedStatus = acceptedStatus
        self.id = id
    }
}
