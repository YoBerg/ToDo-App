//
//  tasksListViewController.swift
//  To Do App
//
//  Created by Macbook on 7/6/18.
//  Copyright © 2018 Yohan Berg. All rights reserved.
//

import UIKit


class ListTasksViewController: UITableViewController{
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    var tasks = [Task]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = CoreDataHelper.retrieveTasks()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = tasks[indexPath.row]
            CoreDataHelper.delete(task: taskToDelete)
            
            tasks = CoreDataHelper.retrieveTasks()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTaskCell", for: indexPath) as! ListTasksCell
        
        let task = tasks[indexPath.row]
        cell.taskTitleLabel.text = task.title
        // 1
        cell.modificationTimeLabel.text = task.modificationTime?.convertToString() ?? "unknown"
        cell.previewTextBox.text = task.content
        if task.complete == false {
            cell.completionBox.setTitle("O", for: .normal)
        } else {
            cell.completionBox.setTitle("√", for: .normal)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayNote":
            // 1
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            // 2
            let task = tasks[indexPath.row]
            // 3
            let destination = segue.destination as! displayTasksViewController
            // 4
            destination.task = task
        case "addTask":
            print("create task bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
}

extension Date {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
}

extension NSDate {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: (self as Date), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
}
