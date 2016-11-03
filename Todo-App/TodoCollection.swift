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
    
    var hoge: NSArray = []
    
    var keepList:[Todo] = []
    var problemList:[Todo] = []
    var dailyTryList:[Todo] = []
    var weeklyTryList:[Todo] = []
    var otherTryList:[Todo] = []
    
    func fetchTodos(inout array: Array<Todo>, type: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let todoList = defaults.objectForKey(type) as? Array<Dictionary<String, AnyObject>> {
            for todoDic in todoList {
                let todo = TodoCollection.convertTodoModel(todoDic)
                array.append(todo)
            }
        }
    }
    
    func addTodoCollection(inout array: Array<Todo>, todo: Todo, type: String) {
        array.append(todo)
        self.save(&array, type: type)
    }
    
    func save(inout array: Array<Todo>, type: String) {
        var todoList: Array<Dictionary<String, AnyObject>> = []
        for todo in array {
            let todoDic = TodoCollection.convertDictionary(todo)
            todoList.append(todoDic)
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
        dic["frequency"] = todo.frequency.rawValue
        return dic
    }
    
    class func convertTodoModel(attiributes: Dictionary<String, AnyObject>) -> Todo {
        let todo = Todo()
        todo.title = attiributes["title"] as! String
        todo.descript = attiributes["descript"] as! String
        todo.priority = TodoPriority(rawValue: attiributes["priority"] as! Int)!
        todo.frequency = TodoFrequency(rawValue: attiributes["frequency"] as! Int)!
        return todo
    }
}
