//
//  DataProviderTests.swift
//  ToDoAppTests
//
//  Created by Mitrio on 15.07.2022.
//

import XCTest
@testable import ToDoApp

class DataProviderTests: XCTestCase {

    var sut: DataProvider!
    var tableView: UITableView!
    var controller: TaskListViewController!
    
    override func setUpWithError() throws {
        sut = DataProvider()
        sut.taskManager = TaskManager()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as? TaskListViewController
        controller.loadViewIfNeeded()
        tableView = controller.tableView
        tableView.dataSource = sut
    }
    override func tearDownWithError() throws {
    }
    
    func testNumberOfSectionsIsTwo() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    func testNumberOfRowsInSectionZeroIsTasksCount() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        sut.taskManager?.add(task: Task(title: "Bar"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    func testNumberOfRowsInSectionOneIsDoneTasksCount() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        sut.taskManager?.add(task: Task(title: "Bar"))
        sut.taskManager?.checkTask(at: 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    func testCellForRowAtIndexOathReturnsTaskCell() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is TaskCell)
    }
    func testCellForRowAtIndexPathDequesCellFromTableView() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(TaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
        sut.taskManager?.add(task: Task(title: "Foo"))
        mockTableView.reloadData()
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellIsDequed)
    }
    func testCellForRowInSectionZeroCallsConfigure() {
        tableView.register(MockTaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
        let task = Task(title: "Foo")
        sut.taskManager?.add(task: task)
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTaskCell
        XCTAssertEqual(cell.task, task)
    }
    func testCellForRowInSectionOneCallsConfigure() {
        tableView.register(MockTaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
        let task = Task(title: "Foo")
        sut.taskManager?.add(task: task)
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        XCTAssertEqual(cell.task, task)
    }
}

extension DataProviderTests {
    class MockTableView: UITableView {
        var cellIsDequed = false
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequed = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockTaskCell: TaskCell {
        var task: Task?
        override func configure(with task: Task) {
            self.task = task
        }
    }
}
