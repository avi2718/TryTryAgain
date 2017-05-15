//
//  Task.swift
//  Productivize
//
//  Created by Bhairavi Chandersekhar on 5/14/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import Foundation

struct Task: CustomStringConvertible {
    
    static var allTasks: [Task] = []
    var name: String
    var dueDate: Date
    var category: String
    var length: TimeInterval
    var minChunk: TimeInterval
    
    init(name: String, dueDate: Date, category: String, length: TimeInterval, minChunk: TimeInterval) {
        self.name = name
        self.dueDate = dueDate
        self.category = category
        self.length = length
        self.minChunk = minChunk
        Task.allTasks.append(self)
    }
    
    var description: String {
        return name
    }

}
