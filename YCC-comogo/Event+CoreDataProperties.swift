//
//  Event+CoreDataProperties.swift
//  YCC-comogo
//
//  Created by James Jung on 12/1/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var title: String?
    @NSManaged public var eventDescription: String?
    @NSManaged public var eventStart: NSDate? //accessing through a computed property in the core data class
    @NSManaged public var eventEnd: NSDate? //accessing through a computed property in the core data class
    @NSManaged public var category: String?
    @NSManaged public var datePosted: NSDate? //accessing through a computed property in the core data class
    @NSManaged public var location: String?
    @NSManaged public var acceptedStatus: String?
    @NSManaged public var id: String?
}
