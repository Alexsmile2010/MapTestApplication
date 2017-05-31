//
//  Utilities.swift
//  mvp-template
//
//  Created by Vedidev on 24/04/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import Foundation
import MBProgressHUD
import Async

class Utilities {
    static let shared = Utilities()
    
    private init() {}
    
    // MARK: - variables
    
    lazy var rootWindow = UIApplication.shared.windows.last
    var hud = MBProgressHUD()
    {
        didSet
        {
            hud.backgroundView.style = .solidColor
            hud.backgroundView.color = UIColor(white: 0, alpha: 0.1)
        }
    }
    
    // MARK: - HUDs
    
    class func showHUD()
    {
        Async.main {
            
            if let app = UIApplication.shared.delegate , let window = app.window
            {
                if window?.subviews.containsType(of: MBProgressHUD.self) == false
                {
                    MBProgressHUD.showAdded(to: window!, animated: true)
                }
            }
        }
    }
    
    class func hideHUD()
    {
        Async.main {
            if let app = UIApplication.shared.delegate, let window = app.window
            {
                MBProgressHUD.hideAllHUDs(for: window!, animated: true)
            }
        }
    }

}
