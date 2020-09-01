//
//  HttpClient.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 2/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import Alamofire
import HandyJSON



class HttpClient {
    
    private init() {}
    
    static private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return SessionManager(configuration: configuration)
    }()

    
    
    static func post<T>(
        _ url: String,
        _ parameters: Parameters?,
        _ block: @escaping (HttpClientResponse<T>) -> Void)
        -> DataRequest
    {
        return normalDataRequest(url, .post, parameters, nil, block)
    }
    

    static func get<T>(
        _ url: String,
        _ parameters: Parameters?,
        _ block: @escaping (HttpClientResponse<T>) -> Void)
        -> DataRequest
    {
        return normalDataRequest(url, .get, parameters, nil, block)
    }
    
    private static func normalDataRequest<T>(
        _ url: String,
        _ method: HTTPMethod,
        _ parameters: Parameters?,
        _ extraHeader: HTTPHeaders? = nil,
        _ block: @escaping (HttpClientResponse<T>) -> Void)
        -> DataRequest
    {
        
        var header: HTTPHeaders = [:]
        
        for (key, value) in (extraHeader ?? [:]) {
            header[key] = value
        }
        
        
        let dataRequest = sessionManager.request(url,
                                                 method: method,
                                                 parameters: parameters,
                                                 encoding: method == HTTPMethod.get ? URLEncoding.default : JSONEncoding.default,
                                                 headers: header)
        
        return dataRequest.responseJSON { (response) in handleReponse(response, block) }
    }
    
    private static func handleReponse<T>(
        _ response: DataResponse<Any> ,
        _ block: @escaping (HttpClientResponse<T>) -> Void)
    {
            switch response.result {
            case .success(let value):
                
                let businessData = BusinessData<T>.deserialize(from: value as? [String : Any])
                guard let _ = businessData else {
                    block(HttpClientResponse.failure(.serverDisable("服务器开小差了~")))
                    return
                }
                
                if businessData!.success {
                    block(HttpClientResponse.success(businessData!))
                } else {
                    block(HttpClientResponse.failure(.businessError(businessData!)))
                }
                
            case .failure(let err):
                let error = err as NSError
                let isCancel = error.code == NSURLErrorCancelled && error.domain == NSURLErrorDomain
                block(HttpClientResponse.failure(isCancel ? .canceled : .httpError(err.localizedDescription)))
            }
    }
    
}


enum HttpClientResponse<T> {
    
    enum HttpClientResponseError: Error {
        case httpError(String)                  //非业务上的错误
        case canceled                           //代码上取消的
        case serverDisable(String)              //返回的东西不是字典
        case businessError(BusinessData<T>)     //业务上的错误
        
        var errorMsg: String? {
            switch self {
            case .httpError(let s),
                 .serverDisable(let s):
                return s
            case .businessError:
                return "服务端开小差啦~"
            default:
                return nil
            }
        }
    }
    
    case success(BusinessData<T>)
    case failure(HttpClientResponseError)
}



class BusinessData<T>: HandyJSON {
    required init() {}
    
    var help: String = ""
    var success = false
    var result: T?
}





