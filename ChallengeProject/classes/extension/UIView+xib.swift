//
//  UIView+xib.swift
//  ChallengeProject
//
//  Created by mac on 2020/9/1.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import UIKit

extension UIView{
    
    static func loadXib(_ bundle: Bundle? = nil) -> Self {
        let b = bundle ?? Bundle.main
        let name = String(describing: self)
        return b.loadNibNamed(name, owner: nil, options: nil)!.first as! Self
    }
    
    
}
