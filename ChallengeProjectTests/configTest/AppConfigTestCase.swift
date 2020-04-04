//
//  AppConfigTestCase.swift
//  ChallengeProjectTests
//
//  Created by 梁齐才 on 2020/4/4.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import XCTest
@testable import ChallengeProject

class AppConfigTestCase: BaseTestCase {
    
    func testIsRelease() {
        //given  when
        let rs = AppConfig.isRelease
        
        //then
        XCTAssertEqual(rs, true)
    }
    
    
    func testWebUrl() {
        //given  when
        let rs = AppConfig.webServerURL
        
        //then
        XCTAssertEqual(rs, "https://data.gov.sg")
    }
    
}
