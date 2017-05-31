//
//  Alert.swift
//  mvp-template
//
//  Created by Vedidev on 24/04/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import UIKit

class Alert {
    private var alert: UIAlertController!
    
    init (title: String, message: String, style: UIAlertControllerStyle)
    {
        self.alert = UIAlertController(title: title, message: message, preferredStyle: style)
    }
    
    func addAction(title: String, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) -> Alert
    {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        self.alert.addAction(action)
        
        return self
    }
    
    func show()
    {
        UIApplication.shared.windows.last?.rootViewController?.present(self.alert, animated: true, completion: nil)
    }
    
}
