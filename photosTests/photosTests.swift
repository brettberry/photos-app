//
//  photosTests.swift
//  photosTests
//
//  Created by Brett Berry on 9/27/15.
//  Copyright © 2015 Brett Berry. All rights reserved.
//

import XCTest
@testable import photos

class photosTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequest() {
        let readyExpectation = expectationWithDescription("ready")
        
        Request("http://google.com")
            .send({ response in
                XCTAssertNil(response.error)
                readyExpectation.fulfill()
            })
        
        waitForExpectationsWithTimeout(5000, handler: { error in
            XCTAssertNil(error)
        })
    }
}
