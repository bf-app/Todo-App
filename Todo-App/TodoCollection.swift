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
    var dailyTryList:[Todo] = []
    var weeklyTryList:[Todo] = []
    var otherTryList:[Todo] = []
    
    // ifぶんのところは条件分岐じゃなくて引数で処理できるように分けたいけどできないからひとまず
    func fetchTodos(type: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let todoList = defaults.objectForKey(type) as? Array<Dictionary<String, AnyObject>> {
            for todoDic in todoList {
                let todo = TodoCollection.convertTodoModel(todoDic)
                // こんな感じで連結できればよさそう
                // self."\(type)" + .append(todo)
                if type == "keepList" {
                    self.keepList.append(todo)
                } else if type == "problemList" {
                    self.problemList.append(todo)
                } else if type == "dailyTryList" {
                    self.dailyTryList.append(todo)
                } else if type == "weeklyTryList" {
                    self.weeklyTryList.append(todo)
                } else {
                    self.otherTryList.append(todo)
                }
            }
        }
    }
    
    // ここも
    func addTodoCollection(todo: Todo, type: String) {
        if type == "keepList" {
            self.keepList.append(todo)
        } else if type == "problemList" {
            self.problemList.append(todo)
        } else if type == "dailyTryList" {
            self.dailyTryList.append(todo)
        } else if type == "weeklyTryList" {
            self.weeklyTryList.append(todo)
        } else {
            self.otherTryList.append(todo)
        }
        
        self.save(type)
    }
    
    func save(type: String) {
        var todoList: Array<Dictionary<String, AnyObject>> = []
        // 要リファクタリング
        // 引数で判定をしたいが、うまくいかないからとりあえずこれ
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
        } else if type == "dailyTryList" {
            for todo in dailyTryList {
                let todoDic = TodoCollection.convertDictionary(todo)
                todoList.append(todoDic)
            }
        } else if type == "weeklyTryList" {
            for todo in weeklyTryList {
                let todoDic = TodoCollection.convertDictionary(todo)
                todoList.append(todoDic)
            }
        } else {
            for todo in otherTryList {
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
