//
//  AppConfig.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 2/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

struct AppConfig {
    private enum AppConfigType {
        case Debug
        case Uat
        case Release
    }
    
    private static var currentConfig: AppConfigType {
        return .Release
    }
    
    static var isRelease: Bool {
        return currentConfig == AppConfigType.Release
    }
    
    
    // MARK: - 接口地址   这个地方配制接口网址
    static var webServerURL: String {
        switch currentConfig {
        case .Debug:
            return "https://data.gov.sg"
        case .Uat:
            return "https://data.gov.sg"
        case .Release:
            return "https://data.gov.sg"
        }
    }
    
}
