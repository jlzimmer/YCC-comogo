//
//  DecodableEvent.swift
//  YCC-comogo
//
//  Created by James Jung on 12/2/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//


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
    var attendingUsers: [String]
    var url: String
    var v: Int
    
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
        case attendingUsers
        case v = "__v"
        case url
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
        self.v = 0
        self.url = ""
        self.attendingUsers = []
    }
}

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}
