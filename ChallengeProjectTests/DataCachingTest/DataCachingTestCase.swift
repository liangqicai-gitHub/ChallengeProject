//
//  DataCachingTestCase.swift
//  ChallengeProjectTests
//
//  Created by 梁齐才 on 2020/4/4.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import XCTest
@testable import ChallengeProject
import FMDB

class DataCachingTestCase: BaseTestCase {
    
    func testDataBaseToolInit() {
        //given
        let queue = DataBaseTool.shared.queue
        var result: Result<FMResultSet,Error>?
        
        //when
        queue?.inDatabase({ (db) in   //this is block is synchronous
            result = Result {
                try
                db.executeQuery("SELECT COUNT(*) count FROM sqlite_master where type='table' and name='?'",
                                values: ["T_quarter"])
            }
        })
        
        //then
        XCTAssertNotNil(queue, "fail to connect to sqlite")
        XCTAssertEqual(result?.success?.next(), true, "fail to create table T_quarter")
    }
}


class CPHomeDataCaheToolTestCase: BaseTestCase {
    
    func testInsertAndSelect() {
        //given
        let queue = DataBaseTool.shared.queue
        queue?.inDatabase({ (db) in   //this is block is synchronous
            let _ = Result {try db.executeUpdate("DELETE FROM T_quarter", values: nil)}
        })
        
        var list: [CPQuarterReportModel] = []
        for index in 1...30 {
            let m = CPQuarterReportModel()
            m._id = index
            m.quarter = "sdfdsfad" + "\(index)"
            m.volume_of_mobile_data = "dsfadfasdfasf" + "\(index)"
            list.append(m)
        }
        
        var selectedList: [CPQuarterReportModel]?
                
        //when
        CPHomeDataCaheTool.insert(list)
        CPHomeDataCaheTool.select(offset: 0, limit: 100) { (rs) in //this is block is synchronous
            selectedList = rs
        }
        
        //then
        XCTAssertEqual(selectedList?.count, 30, "insert or select from T_quarter wrong")
        XCTAssertEqual(selectedList?.first?._id, 1, "insert or select from T_quarter wrong")
        XCTAssertEqual(selectedList?.last?._id, 30, "insert or select from T_quarter wrong")
        
    }
    
}
