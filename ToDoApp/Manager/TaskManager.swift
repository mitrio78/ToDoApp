//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Mitrio on 14.07.2022.
//

import Foundation

final class TaskManager {
    
    var tasksCount: Int {
        return tasks.count
    }
    
    var doneTasksCount: Int {
        return doneTasks.count
    }
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    func add(task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        } else {
            return
        }
    }
    
    func task(at: Int) -> Task {
        return tasks[at]
    }
    
    func checkTask(at index: Int) {
        let task = tasks.remove(at: index)
        doneTasks.append(task)
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTasks[index]
    }
    func removeAll() {
        tasks.removeAll()
        doneTasks.removeAll()
    }
}
