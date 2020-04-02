//
//  UIViewController.swift
//  ChallengeProject
//
//  Created by 孙宁宁 on 2/4/2020.
//  Copyright © 2020 梁齐才. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast

extension UIView{
    
    private struct AssociatedKeys {
          static var hudKey = "UIView.hudKey"
    }
    
    private var loadingHud: MBProgressHUD? {
        get {
          return objc_getAssociatedObject(self, &AssociatedKeys.hudKey) as? MBProgressHUD
        }
        set {
           objc_setAssociatedObject(self, &AssociatedKeys.hudKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    
    func hud_showLoading() {
        Thread.safe_main {
            guard self.loadingHud == nil else {return}
            let hud = MBProgressHUD.showAdded(to: self, animated: true)
            hud.mode = .indeterminate;
            self.loadingHud = hud
        }
    }
    

    func hud_hideLoading() {
        Thread.safe_main {
            guard let hud = self.loadingHud else {return}
            hud.hide(animated: true)
            self.loadingHud = nil
        }
    }
    
    
    func hud_showToast(_ title: String?) {
        guard let titleString = title  else {return}
        guard titleString.count > 0 else {return}
        self.makeToast(titleString, duration: 2.0, position: CSToastPositionCenter)
    }
    
}

