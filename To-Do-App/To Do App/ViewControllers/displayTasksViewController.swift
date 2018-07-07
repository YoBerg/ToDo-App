//
//  displayTasksViewController.swift
//  To Do App
//
//  Created by Macbook on 7/7/18.
//  Copyright © 2018 Yohan Berg. All rights reserved.
//

import UIKit

class displayTasksViewController: UIViewController {
    
    var task: Task?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1
        if let task = task {
            // 2
            titleTextField.text = task.title
            contentTextView.text = task.content
        } else {
            // 3
            titleTextField.text = ""
            contentTextView.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "save" where task != nil:
            task?.title = titleTextField.text ?? ""
            task?.content = contentTextView.text ?? ""
            task?.modificationTime = Date()
            
            CoreDataHelper.saveTask()
            
        case "save" where task == nil:
            let task = CoreDataHelper.newTask()
            task.title = titleTextField.text ?? ""
            task.content = contentTextView.text ?? ""
            task.modificationTime = Date()
            
            CoreDataHelper.saveTask()
            
        case "cancel":
            print("cancel bar button item tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
}
