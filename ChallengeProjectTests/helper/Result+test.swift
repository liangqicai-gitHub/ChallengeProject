//
//  Result+test.swift
//  ChallengeProjectTests
//
//  Created by 梁齐才 on 2020/4/4.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import Foundation
@testable import ChallengeProject

extension Result {
    var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }

    var isFailure: Bool {
        return !isSuccess
    }

    var success: Success? {
        guard case let .success(value) = self else { return nil }
        return value
    }

    var failure: Failure? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}


extension HttpClientResponse {
    
    var success: BusinessData<T>? {
        guard case let HttpClientResponse.success(value) = self else {return nil}
        return value
    }
    
    
}
