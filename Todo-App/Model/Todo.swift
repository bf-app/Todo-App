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
            return UIColor.greenColor()
        case .High:
            return UIColor.redColor()
        }
    }
}

class Todo: NSObject {
    var title = ""
    var descript = ""
    var priority:TodoPriority = .Low
    
}
