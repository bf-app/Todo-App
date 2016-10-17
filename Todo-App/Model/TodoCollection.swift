//
//  TodoCollection.swift
//  Todo-App
//
//  Created by 藤川文汰 on 10/4/16.
//  Copyright © 2016 fujikawa bunta. All rights reserved.
//

import UIKit

class TodoCollection: NSObject {
    static let sharedInstance = TodoCollection()
    
    var keepList:[Todo] = []
    var problemList:[Todo] = []
    var tryList:[Todo] = []
    
    func fetchTodos(type: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let todoList = defaults.objectForKey(type) as? Array<Dictionary<String, AnyObject>> {
            for todoDic in todoList {
                let todo = TodoCollection.convertTodoModel(todoDic)
                if type == "keepList" {
                    self.keepList.append(todo)
                } else if type == "problemList" {
                    self.problemList.append(todo)
                } else if type == "tryList" {
                    self.tryList.append(todo)
                }
            }
        }
    }
    
    func addTodoCollection(todo: Todo, type: String) {
        if type == "keepList" {
            self.keepList.append(todo)
        } else if type == "problemList" {
            self.problemList.append(todo)
        } else if type == "tryList" {
            self.tryList.append(todo)
        }
        
        self.save(type)
    }
    
    func save(type: String) {
        var todoList: Array<Dictionary<String, AnyObject>> = []
        if type == "keepList" {
            for todo in keepList {
                let todoDic = TodoCollection.convertDictionary(todo)
                todoList.append(todoDic)
            }
        } else if type == "problemList" {
            for todo in problemList {
                let todoDic = TodoCollection.convertDictionary(todo)
                todoList.append(todoDic)
            }
        } else if type == "tryList" {
            for todo in tryList {
                let todoDic = TodoCollection.convertDictionary(todo)
                todoList.append(todoDic)
            }
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(todoList, forKey: type)
        defaults.synchronize()
    }
    
    class func convertDictionary(todo: Todo) -> Dictionary<String, AnyObject> {
        var dic = Dictionary<String, AnyObject>()
        dic["title"] = todo.title
        dic["descript"] = todo.descript
        dic["priority"] = todo.priority.rawValue
        return dic
    }
    
    class func convertTodoModel(attiributes: Dictionary<String, AnyObject>) -> Todo {
        let todo = Todo()
        todo.title = attiributes["title"] as! String
        todo.descript = attiributes["descript"] as! String
        todo.priority = TodoPriority(rawValue: attiributes["priority"] as! Int)!
        return todo
    }
}
