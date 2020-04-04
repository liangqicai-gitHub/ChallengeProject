//
//  BaseTestCase.swift
//  ChallengeProjectTests
//
//  Created by 梁齐才 on 2020/4/4.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import XCTest
@testable import ChallengeProject

class BaseTestCase: XCTestCase {
    
    func assert(on queue: DispatchQueue, timeout: TimeInterval, assertions: @escaping () -> Void) {
        let expect = expectation(description: "all assertions are complete")

        queue.async {
            assertions()
            expect.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
}
