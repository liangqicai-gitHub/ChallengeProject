//
//  ModelsTestCase.swift
//  ChallengeProjectTests
//
//  Created by 梁齐才 on 2020/4/4.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import XCTest
@testable import ChallengeProject

class ModelsTestCase: BaseTestCase {
    
}


class CPQuarterReportModelTestCase: BaseTestCase {
    
    
    func testYearAndQuarterIndex() {
        
        //given
        let m1 = CPQuarterReportModel()
        m1._id = 0
        m1.volume_of_mobile_data = "0.23"
        m1.quarter = "2020-Q3"
        
        let m2 = CPQuarterReportModel()
        m2._id = 2
        m2.volume_of_mobile_data = "0.22"
        m2.quarter = "2020Q3"
        
        let m3 = CPQuarterReportModel()
        m3._id = 3
        m3.volume_of_mobile_data = "0.21"
        m3.quarter = "2020-3"
        
        let m4 = CPQuarterReportModel()
        m4._id = 4
        m4.volume_of_mobile_data = "0.21"
        m4.quarter = ""
        
        
        //when
        let m1yeaer = m1.year
        let m1Quarter = m1.quarterIndex
        
        let m2yeaer = m2.year
        let m2Quarter = m2.quarterIndex
        
        let m3yeaer = m3.year
        let m3Quarter = m3.quarterIndex
        
        let m4yeaer = m4.year
        let m4Quarter = m4.quarterIndex
        
        //then
        XCTAssertEqual(m1yeaer, 2020)
        XCTAssertEqual(m1Quarter, 3)
        XCTAssertNil(m2yeaer)
        XCTAssertEqual(m2Quarter, 3)
        XCTAssertEqual(m3yeaer, 2020)
        XCTAssertNil(m3Quarter)
        XCTAssertNil(m4yeaer)
        XCTAssertNil(m4Quarter)
    }
    
}


class CPYearQuarterReportModelTestCase: BaseTestCase {
    
    let m1: CPYearQuarterReportModel = {
        let rs = CPYearQuarterReportModel()
        rs.quarters = ["1","2","3","4"]
        rs.isStateOpen = false
        return rs
    }()
    
    
    let m2: CPYearQuarterReportModel = {
        let rs = CPYearQuarterReportModel()
        rs.quarters = ["5","2","3","4"]
        rs.isStateOpen = true
        return rs
    }()
    

    func testDecrease() {
        // given  when
        let m1hasDecrease = m1.hasDecrease
        let m2hasDecrease = m2.hasDecrease
        
        //then
        XCTAssertEqual(m1hasDecrease, false)
        XCTAssertEqual(m2hasDecrease, true)
    }
    
    
    func testCalculate() {
        // given  when
        let m1Max = m1.max
        let m1Min = m1.min
        let m1Ave = m1.average
        
        XCTAssertEqual(m1Max, 4.0)
        XCTAssertEqual(m1Min, 0.0)
        XCTAssertEqual(m1Ave, 0.8)
    }
    
    func testCellHeight() {
        // given when
        let height1 = m1.homePageCellHeight
        let height2 = m2.homePageCellHeight
        
        XCTAssertEqual(height1, 41.0)
        XCTAssertEqual(height2, 228.0)
    }
    
}


class arrayWithElementCPYearQuarterReportModelTestCase: BaseTestCase {
    
    func testGenerateNewYearModel() {
        //given
        let m1 = CPYearQuarterReportModel()
        m1.year = 2001
        m1.quarters = ["0.5"]
        var years = [m1]
        
        let qm1 = CPQuarterReportModel()
        qm1.quarter = "2001-Q2"
        qm1.volume_of_mobile_data = "0.6"
    
        
        let qm2 = CPQuarterReportModel()
        qm2.quarter = "2001-Q3"
        qm2.volume_of_mobile_data = "0.7"
      
        let qm3 = CPQuarterReportModel()
        qm3.quarter = "2001-Q4"
        qm3.volume_of_mobile_data = "0.8"
      
        let qm4 = CPQuarterReportModel()
        qm4.quarter = "2002-Q1"
        qm4.volume_of_mobile_data = "0.9"
        
        let qm5 = CPQuarterReportModel()
        qm5.quarter = "2002-Q2"
        qm5.volume_of_mobile_data = "1.0"
        
        
        //when
        years.generateNewYearModel([qm1,qm2,qm3,qm4,qm5])
        
        
        //then
        XCTAssertEqual(years.count, 2)
        XCTAssertEqual(years.first?.quarters, ["0.5","0.6","0.7","0.8"])
        XCTAssertEqual(years.last?.quarters, ["0.9","1.0"])
        
    }
    
}
