//
//  CHDataStoresearchAPI.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 2/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

class CPDataStoresearchAPI: BaseHttpApi {
    
 
    //获取数据
    @discardableResult
    class func getdata(offset: Int,
                       limit: Int,
                       block: @escaping (HttpClientResponse<[CPQuarterReportModel]>) -> Void)
        -> DataRequest
    {
        let p: [String : Any] = ["offset": offset,
                                 "limit" : limit,
                                 "resource_id" : "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"]
        
        let callback = { (httpResponse: HttpClientResponse<[String : Any]>) in
            switch httpResponse {
            case .success(let data):
                if let result = data.result,
                    let records = result["records"] as? Array<Any> {
    
                    let keyValues = ([CPQuarterReportModel].deserialize(from: records) as? [CPQuarterReportModel]) ?? []
                    let realData = BusinessData<[CPQuarterReportModel]>()
                    realData.help = data.help
                    realData.success = data.success
                    realData.result = keyValues
                    block(HttpClientResponse.success(realData))
                    
                } else {
                    block(HttpClientResponse.failure(.httpError("服务器开小差了~")))
                }
            case .failure(let err):
                block(HttpClientResponse.failure(.httpError(err.errorMsg ?? "服务器开小差了~")))
            }
        }
        
        return HttpClient.get(BaseUrl + "/api/action/datastore_search",
                              p,
                              callback)
    }
}
