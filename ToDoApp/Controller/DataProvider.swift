//
//  DataProvider.swift
//  ToDoApp
//
//  Created by Mitrio on 15.07.2022.
//

import Foundation
import UIKit

enum Sections: Int {
    case toDo
    case done
}

final class DataProvider: NSObject {
    var taskManager: TaskManager?
}
extension DataProvider: UITableViewDelegate {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: indexPath) as! TaskCell
        let task = taskManager?.task(at: indexPath.row)
        guard let task = task else { return UITableViewCell() }
        cell.configure(with: task)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}
