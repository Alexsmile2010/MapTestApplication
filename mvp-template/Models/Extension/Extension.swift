//
//  Extension.swift
//  mvp-template
//
//  Created by Vedidev on 29.05.17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import Foundation
import UIKit
import EZSwiftExtensions

extension UITableView
{
    func dequeueReusableCell<T: UITableViewCell>(_ withClass: T.Type, for indexPath: IndexPath) -> T
    {
        return self.dequeueReusableCell(withIdentifier: String(describing: withClass), for: indexPath) as! T
    }
    
    func registerNib()
    {
        self.register(UINib(nibName: RestaurantInfoCell.className, bundle: nil), forCellReuseIdentifier:RestaurantInfoCell.className)
    }
}
