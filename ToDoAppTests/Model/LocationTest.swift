//
//  LocationTest.swift
//  ToDoAppTests
//
//  Created by Mitrio on 13.07.2022.
//

import XCTest
@testable import ToDoApp
import CoreLocation

class LocationTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitSetsName() {
        let name = "Foo"
        let location = Location(name: name)
        XCTAssertEqual(location.name, name)
    }
    
    func testInitSetsCoordinates() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
    }
}
