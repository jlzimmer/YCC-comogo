//
//  DecodableEvent.swift
//  YCC-comogo
//
//  Created by James Jung on 12/2/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import Foundation

import Foundation

struct YccEvent: Codable {
    var title: String
    var description: String
    var start: Date
    var end: Date
    var category: String
    var posted: Date
    var location: String
    var hostUser: String
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case start
        case end
        case category
        case posted
        case location
        case hostUser
        case id = "_id"
    }
    
    init(title: String, description: String, start: Date, end: Date, category: String, posted: Date, location: String, id: String) {
        self.title = title
        self.description = description
        self.start = start
        self.end = end
        self.posted = posted
        self.location = location
        self.category = category
        self.id = id
        self.hostUser = "placeholder"
    }
}
