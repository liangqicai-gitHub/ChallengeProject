//
//  UIViewController+sb+xib.swift
//  ChallengeProject
//
//  Created by mac on 2020/9/1.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func loadSb(_ bundle: Bundle? = nil, _ sbName: String) -> Self {
        let nib = UIStoryboard(name: sbName, bundle: bundle)
        return nib.instantiateViewController(identifier: String(describing: self)) as! Self
    }
    
}
