//
//  TaskManagerTest.swift
//  ToDoAppTests
//
//  Created by Mitrio on 14.07.2022.
//

import XCTest
@testable import ToDoApp

class TaskManagerTest: XCTestCase {

    var sut: TaskManager!
    
    override func setUp() {
        sut = TaskManager()
    }
    
    override func tearDown() {
        sut = nil
    }

    func testInitTaskManagerWithZeroTask() {
        XCTAssertEqual(sut.tasksCount, 0)
    }
    func testInitTaskManagerWithZeroDoneTask() {
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    func testAddTaskIncrementTaskCount() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        XCTAssertEqual(sut.tasksCount, 1)
    }
    func testTaskAtIndexIsAddedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        let returnedTask = sut.task(at: 0)
        XCTAssertEqual(task, returnedTask)
    }
    func testChackTaskAtIndexChangesCounts() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.tasksCount, 0)
        XCTAssertEqual(sut.doneTasksCount, 1)
    }
    func testCheckedTaskRemovedFromTasks() {
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.task(at: 0), secondTask)
    }
    func testDoneTasksAtReturnsCheckedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        
        let returnedTask = sut.doneTask(at: 0)

        XCTAssertEqual(returnedTask, task)
    }
    func testRemoveAllResultsCountsBeZero() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Bar"))
        sut.checkTask(at: 0)
        sut.removeAll()
        XCTAssertTrue(sut.doneTasksCount == 0)
        XCTAssertTrue(sut.tasksCount == 0)
    }
    func testAddingSameObjectsDoesntIncrementCount() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Foo"))
        
        XCTAssertTrue(sut.tasksCount == 1)
    }
}
