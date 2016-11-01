//
//  TryListTableViewController.swift
//  Todo-App
//
//  Created by 藤川文汰 on 10/05/16.
//  Copyright © 2016 fujikawa bunta. All rights reserved.
//

import UIKit

class TryListTableViewController: UITableViewController {
    // todocollectionと同じようなリファクタが必要だけどひとまず
    
    let todoCollection = TodoCollection.sharedInstance
    
    // TODO: 頻度は使用してみて変更する
    private let mySections:NSArray = ["Daily","Weekly","Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        todoCollection.fetchTodos("dailyTryList")
        todoCollection.fetchTodos("weeklyTryList")
        todoCollection.fetchTodos("otherTryList")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 新規作成ボタン
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新規作成", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TryListTableViewController.newTodo))
        
        // edit
        self.navigationItem.leftBarButtonItem = editButtonItem()
        
        self.tableView.reloadData()
    }
    
    func newTodo() {
        self.performSegueWithIdentifier("PresentNewTryViewController", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // section数
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mySections.count
    }
    
    // section内のrow数表示
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return self.todoCollection.dailyTryList.count
        } else if section == 1 {
            return self.todoCollection.weeklyTryList.count
        } else if section == 2 {
            return self.todoCollection.otherTryList.count
        } else {
            return 0
        }
    }
    
    // section名表示
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section] as? String
    }
    
    //　trylistを表示
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "tryIdentifier")
        cell.textLabel!.font = UIFont(name: "HirakakuProN-W3", size: 15)
        
        let priorityIcon = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        priorityIcon.layer.cornerRadius = 6

        if indexPath.section == 0 {
            let daily = self.todoCollection.dailyTryList[indexPath.row]
            cell.textLabel!.text =  daily.title
            cell.detailTextLabel!.text = daily.descript
            priorityIcon.backgroundColor = daily.priority.color()
        } else if indexPath.section == 1 {
            let weekly = self.todoCollection.weeklyTryList[indexPath.row]
            cell.textLabel!.text = weekly.title
            cell.detailTextLabel!.text = weekly.descript
            priorityIcon.backgroundColor = weekly.priority.color()
        } else if indexPath.section == 2 {
            let other = self.todoCollection.otherTryList[indexPath.row]
            cell.textLabel!.text = other.title
            cell.detailTextLabel!.text = other.descript
            priorityIcon.backgroundColor = other.priority.color()
        }
        
        cell.accessoryView = priorityIcon
        return cell
    }
    
    // 削除
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            if "\(indexPath.section)" == String(0) {
                self.todoCollection.dailyTryList.removeAtIndex(indexPath.row)
                self.todoCollection.save("dailyTryList")
            } else if "\(indexPath.section)" == String(1) {
                self.todoCollection.weeklyTryList.removeAtIndex(indexPath.row)
                self.todoCollection.save("weeklyTryList")
            } else if "\(indexPath.section)" == String(2) {
                self.todoCollection.otherTryList.removeAtIndex(indexPath.row)
                self.todoCollection.save("otherTryList")
            } else {
                return
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
        case .Insert:
            return
        default:
            return
        }
    }
    
    // 編集
    // 頻度の変更ができない状態
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if "\(destinationIndexPath.section)" == String(0) {
            let todo = self.todoCollection.dailyTryList[sourceIndexPath.row]
            self.todoCollection.dailyTryList.removeAtIndex(sourceIndexPath.row)
            self.todoCollection.dailyTryList.insert(todo, atIndex: destinationIndexPath.row)
            self.todoCollection.save("dailyTryList")
            
        } else if "\(destinationIndexPath.section)" == String(1) {
            let todo = self.todoCollection.weeklyTryList[sourceIndexPath.row]
            self.todoCollection.weeklyTryList.removeAtIndex(sourceIndexPath.row)
            self.todoCollection.weeklyTryList.insert(todo, atIndex: destinationIndexPath.row)
            self.todoCollection.save("weeklyTryList")
            
        } else if "\(destinationIndexPath.section)" == String(2) {
            let todo = self.todoCollection.otherTryList[sourceIndexPath.row]
            self.todoCollection.otherTryList.removeAtIndex(sourceIndexPath.row)
            self.todoCollection.otherTryList.insert(todo, atIndex: destinationIndexPath.row)
            self.todoCollection.save("otherTryList")
            
        } else {
            return
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
