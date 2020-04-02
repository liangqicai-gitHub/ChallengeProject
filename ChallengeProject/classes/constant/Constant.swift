//
//  Constant.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 2/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import UIKit

class Constant: NSObject {

}



// MARK:  颜色  项目中只能在这个地方取颜色
extension Constant {
    static var colorWhite1: UIColor { return .white }
    static var colorGreen1: UIColor {return .green}
    static var colorRed1: UIColor {return .red}
}


// MARK:  字体
extension Constant {
    static var font12: UIFont { return UIFont.systemFont(ofSize: 12) }
    static var font12B: UIFont { return UIFont.boldSystemFont(ofSize: 12) }

    static var font14: UIFont { return UIFont.systemFont(ofSize: 14) }
    static var font14B: UIFont { return UIFont.boldSystemFont(ofSize: 14)}
}
