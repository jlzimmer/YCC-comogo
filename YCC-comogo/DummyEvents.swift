//
//  DummyEvents.swift
//  YCC-comogo
//
//  Created by Sara Caponi on 11/28/18.
//  Copyright © 2018 Youth Community Coalition. All rights reserved.
//

import Foundation

struct DummyEvent
{
    
    let title: String
    let startTime: String
    let endTime: String
    let location: String
    let pictureString: String
    
    init(title:String, startTime:String,endTime:String, location: String, pictureString: String ){
        self.title = title
        self.startTime = startTime
        self.endTime = endTime
        self.location = location
        self.pictureString = pictureString
    }
    
}
