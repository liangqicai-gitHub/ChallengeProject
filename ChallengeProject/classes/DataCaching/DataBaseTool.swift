//
//  DataBaseTool.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 3/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import FMDB

class DataBaseTool: NSObject {
    
    static let shared: DataBaseTool = {
        let instance = DataBaseTool()
        instance.createTable()
        return instance
    }()
    
    private override init(){}
    
    let queue = FMDatabaseQueue(
        path: NSSearchPathForDirectoriesInDomains(
        FileManager.SearchPathDirectory.documentDirectory,
        FileManager.SearchPathDomainMask.userDomainMask,
        true).last! + "\\cache.db")
    
    
    private func createTable() -> Void {
        let file = Bundle.main.path(forResource: "db.sql", ofType: nil)!
        let sql = try! String(contentsOfFile: file)
        queue?.inDatabase { (db) in
            let result = db.executeStatements(sql)
            if result {
                print("创建表成功")
            } else {
                print("创建表失败")
            }
        }
    }
    
}
