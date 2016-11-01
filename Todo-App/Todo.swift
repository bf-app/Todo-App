//
//  Todo.swift
//  Todo-App
//
//  Created by 藤川文汰 on 10/4/16.
//  Copyright © 2016 fujikawa bunta. All rights reserved.
//

import UIKit

enum TodoPriority: Int {
    case Low    = 0
    case Middle = 1
    case High   = 2
    
    func color() -> UIColor {
        switch self {
        case .Low:
            return UIColor.yellowColor()
        case .Middle:
            return UIColor.orangeColor()
        case .High:
            return UIColor.redColor()
        }
    }
}

enum TodoFrequency: Int {
    case Daily  = 0
    case Weekly = 1
    case Other  = 2
}

class Todo: NSObject {
    var title = ""
    var descript = ""
    var priority:TodoPriority = .Low
    var frequency:TodoFrequency = .Other
}
