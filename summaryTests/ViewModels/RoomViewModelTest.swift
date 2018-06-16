//
//  RoomViewModelTest.swift
//  summaryTests
//
//  Created by 中川 慶悟 on 2018/06/04.
//  Copyright © 2018年 ArgentVGL. All rights reserved.
//

import XCTest
import RxSwift

class RoomViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func testfindRanksById() {
//        let roomVM: RoomViewModel = RoomViewModel()
//        let expectation = XCTestExpectation(description: "findRanksById")
//        roomVM.findUsersById(id: "0")
//        XCTWaiter.wait(for: [expectation], timeout: 100)
//    }
    
    func testfindRoomById() {
        let roomVM: RoomViewModel = RoomViewModel()
        let expectation = XCTestExpectation(description: "findRoomById")
        roomVM.room.subscribe(onNext: { data in
            print("keigo keigo")
            print(data)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("complete")
        }).disposed(by: disposeBag)
        roomVM.findRoomById(id: "0")
        XCTWaiter.wait(for: [expectation], timeout: 5)
    }
    
}
