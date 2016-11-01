//
//  NewTryViewController.swift
//  Todo-App
//
//  Created by 藤川文汰 on 10/05/16.
//  Copyright © 2016 fujikawa bunta. All rights reserved.
//

import UIKit

class NewTryViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tryField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var frequencySegment: UISegmentedControl!
    
    let todoCollection = TodoCollection.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tryField.delegate = self

        // Do any additional setup after loading the view.
        
        descriptionView.layer.cornerRadius = 5
        descriptionView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).CGColor
        descriptionView.layer.borderWidth = 1
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewTryViewController.tapGesture(_:)))
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        // 閉じるボタン
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewTryViewController.close))
        
        // 保存ボタン
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewTryViewController.save))
    }
    
    // todo4
    func save() {
        if tryField.text!.isEmpty {
            let alertView = UIAlertController(title: "エラー", message: "Tryが記述されていません",preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertView, animated: true, completion: nil)
        } else {
            let todo = Todo()
            todo.title = tryField.text!
            todo.descript = descriptionView.text
            todo.priority = TodoPriority(rawValue: prioritySegment.selectedSegmentIndex)!
            todo.frequency = TodoFrequency(rawValue: frequencySegment.selectedSegmentIndex)!
            
            if "\(todo.frequency)" == "Daily" {
                self.todoCollection.addTodoCollection(todo, type: "dailyTryList")
            } else if "\(todo.frequency)" == "Weekly" {
                self.todoCollection.addTodoCollection(todo, type: "weeklyTryList")
            } else {
                self.todoCollection.addTodoCollection(todo, type: "otherTryList")
            }
            // self.todoCollection.addTodoCollection(todo, type: "tryList")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tapGesture(sender: UITapGestureRecognizer) {
        tryField.resignFirstResponder()
        descriptionView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        tryField.resignFirstResponder()
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
