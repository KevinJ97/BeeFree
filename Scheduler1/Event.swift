//
//  Todo.swift
//  Scheduler1
//
//  Created by Kevin J Nguyen on 9/26/15.
//  Copyright © 2015 Kevin J Nguyen. All rights reserved.
//

import Foundation

class Event{
    var title:String
    var startTime:NSDate
    var endTime:NSDate
    var isStatic:Bool
    
    init(title:String,startTime:NSDate,endTime:NSDate){
        self.title = title
        self.startTime = startTime
        self.endTime = endTime
        self.isStatic = true
    }
}