//
//  CPQuarterReportModel.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 2/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import HandyJSON
import HighPrecisionCalculate


class CPQuarterReportModel: HandyJSON {
    required init() {}
    var _id = 0
    var volume_of_mobile_data = "0.0"
    var quarter = ""  // "2004-Q3"
    
    
    //非服务端返回
    var year: Int? {
        if let year = quarter.split(separator: "-").first {
            return Int(year)
        }
        return nil
    }
    
    var quarterIndex: Int? {
        if let qindex = quarter.split(separator: "Q").last {
            return Int(qindex)
        }
        return nil
    }
}

class CPYearQuarterReportModel: HandyJSON {
    required init() {}
    var year = 0
    var quarters: [String] = []
    
    
    var isStateOpen = false
    
    var hasDecrease: Bool {
        
        get {
            var last = quarters.first ?? "0.0"
            for one in quarters {
                if (one.decimalNumberValue() ?? 0.0) < (last.decimalNumberValue() ?? 0.0) {
                    return true
                }
                last = one
            }
            return false
        }
    }
    
    var min: Double { return 0.0 }
    
    var max: Double {
        get {
            var rs = quarters.first?.decimalNumberValue() ?? 0.0.decimalNumberValue()
            for one in quarters {
                if one.decimalNumberValue() ?? 0.0 > rs {
                    rs = one.decimalNumberValue() ?? 0.0
                }
            }
            return rs.doubleValue
        }
    }
    
    var average: Double {
        return ((max - min).decimalNumberValue() / 5.0).doubleValue
    }
    
}


extension Array where Element: CPYearQuarterReportModel {
    
    mutating func generateNewYearModel(_ quarters: [CPQuarterReportModel]){
        
        var lastYear = self.last ?? CPYearQuarterReportModel()
        
        for one in quarters {
            if (one.year ?? -1) == lastYear.year {
                lastYear.quarters.append(one.volume_of_mobile_data)
            } else {
                if let year = one.year {
                    let newYear = CPYearQuarterReportModel()
                    newYear.year = year
                    newYear.quarters.append(one.volume_of_mobile_data)
                    lastYear = newYear
                    append(newYear as! Element)
                }
            }
        }
    }
}
