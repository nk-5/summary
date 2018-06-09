//
//  RoomViewModelTest.swift
//  summaryTests
//
//  Created by 中川 慶悟 on 2018/06/04.
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import XCTest

class RoomViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testfindRanksById() {
        let roomVM: RoomViewModel = RoomViewModel()
        let expectation = XCTestExpectation(description: "findRanksById")
        roomVM.findRanksById(id: "0", completeHandler: {_,_ in })
        XCTWaiter.wait(for: [expectation], timeout: 100)
    }
    
}
