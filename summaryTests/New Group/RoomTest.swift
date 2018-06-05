//
//  RoomTest.swift
//  summaryTests
//
//  Created by 中川 慶悟 on 2018/06/04.
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import XCTest

class RoomTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testfindRanksById() {
        let expectation = XCTestExpectation(description: "findRanksById")
        Room.findRanksById(id: "0")
        XCTWaiter.wait(for: [expectation], timeout: 100)
    }
    
}
