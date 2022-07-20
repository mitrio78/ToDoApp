//
//  DataProvider.swift
//  ToDoApp
//
//  Created by Mitrio on 15.07.2022.
//

import Foundation
import UIKit

enum Sections: Int, CaseIterable {
    case toDo
    case done
}

final class DataProvider: NSObject {
    var taskManager: TaskManager?
}
extension DataProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        guard let section = Sections(rawValue: indexPath.section) else {
            fatalError()
        }
        switch section {
        case .toDo:
            return "Done"
        case .done:
            return "Undone"
        }
    }
}

extension DataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else {
            fatalError()
        }
        guard let taskManager = taskManager else {
            return 0
        }
        switch section {
        case .toDo:
            return taskManager.tasksCount
        case .done:
            return taskManager.doneTasksCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TaskCell.self),
            for: indexPath
        ) as! TaskCell
        
        let task: Task
        guard let section = Sections(rawValue: indexPath.section) else {
            fatalError()
        }
        guard let taskManager = taskManager else {
            fatalError()
        }
        switch section {
        case .toDo:
            task = taskManager.task(at: indexPath.row)
        case .done:
            task = taskManager.doneTask(at: indexPath.row)
        }
        cell.configure(with: task)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Sections.allCases.count
    }
}
