//
//  CoreDataHelper.swift
//  To Do App
//
//  Created by Macbook on 7/6/18.
//  Copyright © 2018 Yohan Berg. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newTask() -> Task {
        let task = NSEntityDescription.insertNewObject(forEntityName: "Task", into: context) as! Task
        
        return task
    }
    
    static func saveTask() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(task: Task) {
        context.delete(task)
        
        saveTask()
    }
    
    static func retrieveTasks() -> [Task]{
        do {
            let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
}
