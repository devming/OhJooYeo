//
//  OhJooYeoTests.swift
//  OhJooYeoTests
//
//  Created by Minki on 2018. 7. 22..
//  Copyright © 2018년 devming. All rights reserved.
//

import XCTest
@testable import OhJooYeo

class OhJooYeoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPI() {
        App.api.getRecentDatas(date: Date(), version: "aaa") {
            
        }
    }
    
}