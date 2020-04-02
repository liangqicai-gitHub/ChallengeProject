//
//  UIViewController.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 2/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    
    var lqcTop: SnapKit.ConstraintItem {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.snp.top
        } else {
            return topLayoutGuide.snp.bottom
        }
    }
    
    var lqcBottom: SnapKit.ConstraintItem {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.snp.bottom
        } else {
            return bottomLayoutGuide.snp.top
        }
    }
    
}
