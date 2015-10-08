//
//  Todo.swift
//  Scheduler1
//
//  Created by Kevin J Nguyen on 9/26/15.
//  Copyright © 2015 Kevin J Nguyen. All rights reserved.
//

import Foundation

class Todo{
    var title:String
    var dueDate:NSDate
    var duration:Int
    var isStatic:Bool

    init(title:String,duration: Int, dueDate:NSDate){
        self.title = title
        self.dueDate = dueDate
        self.duration = duration
        self.isStatic = false
    }
}