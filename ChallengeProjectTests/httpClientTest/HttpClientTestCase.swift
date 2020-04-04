//
//  HttpClientTestCase.swift
//  ChallengeProjectTests
//
//  Created by 梁齐才 on 2020/4/4.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import XCTest
@testable import ChallengeProject

class HttpClientTestCase: BaseTestCase {
    
    
    
    func testWrongJSON() {
        
        //given
        let url = "https://www.baidu.com" //which response a html
        let parameters = ["key😝" : "Value😕"]
        
        var response: HttpClientResponse<String>?
        let exp = self.expectation(description: "did not get a response in 120s")
        
        //When
        let _ = HttpClient.post(String.self, url,parameters) { (result) in
            response = result
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 122, handler: nil)
        
        
        
        //then
        XCTAssertNotNil(response, "get a nil response")
        
        switch response! {
        case .success:
            XCTAssert(false, "did not catch the wrong response")
        case .failure(let err):
            switch err {
            case .httpError:
                return
            default:
                XCTAssert(false, "catch a httpError as an other error")
            }
        }
    }
    
    
    func testWrongUrl() {
        //given
        let url = "https://dsjflkajdklfsdsfjklasjfk" // wrong url
        let parameters = ["key😝" : "Value😕"]
        
        var response: HttpClientResponse<String>?
        let exp = self.expectation(description: "did not get a response in 120s")
        
        //When
        let _ = HttpClient.get(String.self, url,parameters) { (result) in
            response = result
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 122, handler: nil)
        
        
        
        //then
        XCTAssertNotNil(response, "get a nil response")
        switch response! {
        case .success:
            XCTAssert(false, "did not catch the wrong response")
        case .failure(let err):
            switch err {
            case .httpError:
                return
            default:
                XCTAssert(false, "treat a httpError as an other error")
            }
        }
    }
    
    
    func testCancelError() {
        
        //given
        let url = "https://data.gov.sg/api/action/datastore_search" // right url and response a standerd json
        let p: [String : Any] = ["offset": 0,
                                 "limit" : 20,
                                 "resource_id" : "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"]
        
        var response: HttpClientResponse<[String : Any]>?
        let exp = self.expectation(description: "did not get a response in 120s")
        
        //When
        let dataRequest = HttpClient.post([String : Any].self, url,p) { (result) in
            response = result
            exp.fulfill()
        }
        
        dataRequest.cancel()
        
        waitForExpectations(timeout: 122, handler: nil)
        
        //then
        XCTAssertNotNil(response, "get a nil response")
        
        switch response! {
        case .success:
            XCTAssert(false, "did not catch the wrong response")
        case .failure(let err):
            switch err {
            case .canceled:
                return
            default:
                XCTAssert(false, "treat a httpError as an other error")
            }
        }
        
    }
    
    func testCorrectResponse() {
        //given
        let url = "https://data.gov.sg/api/action/datastore_search" // right url and response a standerd json
        let p: [String : Any] = ["offset": 0,
                                 "limit" : 20,
                                 "resource_id" : "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"]
        
        var response: HttpClientResponse<[String : Any]>?
        let exp = self.expectation(description: "did not get a response in 120s")
        
        //When
        let _ = HttpClient.get([String : Any].self, url,p) { (result) in
            response = result
            exp.fulfill()
        }
    
        waitForExpectations(timeout: 122, handler: nil)
        
        
        //then
        XCTAssertNotNil(response, "get a nil response")
        switch response! {
        case .success(let businessResponse):
            XCTAssertNotNil(businessResponse.result,"did not response correctly")
        case .failure:
            XCTAssert(false, "did not response correctly")
        }
    }
    
}
