//
//  CPHomeDataCaheTool.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 3/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import UIKit

class CPHomeDataCaheTool: NSObject {
    
//    CREATE TABLE IF NOT EXISTS "T_quarter" (
//        "_id" INTEGER NOT NULL PRIMARY KEY,
//        "volume_of_mobile_data" TEXT,
//        "quarter" TEXT,
//    );
    
    static func insert(_ list: [CPQuarterReportModel]) {
        
        guard list.count > 0 else { return }
        
        DataBaseTool.shared.queue?.inTransaction({ (db, rollback) in
            do {
                for one in list {
                    try db.executeUpdate("INSERT INTO T_quarter (_id,volume_of_mobile_data,quarter) VALUES (?,?,?)",
                                         values: [one._id,one.volume_of_mobile_data,one.quarter])
                }
              } catch {
                rollback.pointee = true
              }
            
            
        })
    }
    
    // the block is synchronous
    static func select(offset: Int,
                       limit: Int,
                       block: @escaping ([CPQuarterReportModel]) -> Void)
    {
        DataBaseTool.shared.queue?.inDatabase({ (db) in
            var rs: [CPQuarterReportModel] = []
            do {
                let s = try db.executeQuery("SELECT * FROM T_quarter where _id > ? AND _id <= ?", values: [offset,offset + limit])
                while s.next() {
                    if let oneDic = s.resultDictionary as NSDictionary?,
                        let m = CPQuarterReportModel.deserialize(from: oneDic){
                        rs.append(m)
                    }
                }
            
                Thread.safe_main { block(rs) }
            } catch {
                Thread.safe_main { block(rs) }
            }
        })
    }
    
    
}
