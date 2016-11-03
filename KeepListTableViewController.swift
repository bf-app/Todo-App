//
//  KeepListTableViewController.swift
//  Todo-App
//
//  Created by 藤川文汰 on 10/2/16.
//  Copyright © 2016 fujikawa bunta. All rights reserved.
//

import UIKit

class KeepListTableViewController: UITableViewController {
    let todoCollection = TodoCollection.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        todoCollection.fetchTodos(&self.todoCollection.keepList, type: "keepList")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 新規作成ボタン
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新規作成", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(KeepListTableViewController.newTodo))
        
        // edit
        self.navigationItem.leftBarButtonItem = editButtonItem()
        
        self.tableView.reloadData()
    }
    
    func newTodo() {
        self.performSegueWithIdentifier("PresentNewKeepViewController", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.todoCollection.keepList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "keepIdentifier")
        let todo = self.todoCollection.keepList[indexPath.row]

        cell.textLabel!.text = todo.title
        cell.detailTextLabel!.text = todo.descript
        cell.textLabel!.font = UIFont(name: "HirakakuProN-W3", size: 15)
        
        let priorityIcon = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
        priorityIcon.layer.cornerRadius = 6
        priorityIcon.backgroundColor = todo.priority.color()
        cell.accessoryView = priorityIcon

        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            self.todoCollection.keepList.removeAtIndex(indexPath.row)
            self.todoCollection.save(&self.todoCollection.keepList, type: "keepList")
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
        case .Insert:
            return
        default:
            return
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo = self.todoCollection.keepList[sourceIndexPath.row]
        self.todoCollection.keepList.removeAtIndex(sourceIndexPath.row)
        self.todoCollection.keepList.insert(todo, atIndex: destinationIndexPath.row)
        self.todoCollection.save(&self.todoCollection.keepList, type: "keepList")
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
