//
//  TaskTest.swift
//  ToDoAppTests
//
//  Created by Mitrio on 13.07.2022.
//

import XCTest
@testable import ToDoApp

class TaskTest: XCTestCase {

    func testIfTaskInitByTitle() {
        let task = Task(title: "Foo")
        XCTAssertNotNil(task)
    }
    
    func testIfTaskInitByTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenTitleSetsTitle() {
        let title = "Foo"
        let task = Task(title: title)
        XCTAssertEqual(task.title, title)
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let description = "Bar"
        let task = Task(title: "Foo", description: description)
        XCTAssertEqual(task.description, description)
    }
    func testTaskInitsWithDate() {
        let task = Task(title: "Foo")
        XCTAssertNotNil(task.date)
    }
    
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Foo")
        let task = Task(title: "Bar", description: "Baz", location: location)
        XCTAssertEqual(location, task.location)
    }
}
