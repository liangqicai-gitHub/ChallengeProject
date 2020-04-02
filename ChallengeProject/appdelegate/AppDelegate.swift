//
//  AppDelegate.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 2/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import UIKit


//MARK: SDKS
import Alamofire
import SnapKit
import HandyJSON
import HighPrecisionCalculate



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        if window == nil { window = UIWindow.init() }
        
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        
        let home = CPHomePage()
        let rootNavi = BaseNavigationController(rootViewController: home)
        window?.rootViewController = rootNavi
        
        
        print("\(AppConfig.webServerURL)")
        
        return true
    }
}

