//
//  Presenter.swift
//  mvp-template
//
//  Created by Vedidev on 20/04/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//
import Foundation
import UIKit


enum ViewControllerType: String
{
    case ViewController
}

class Presenter
{
    class func viewControllerWithType(_ type: ViewControllerType) -> UIViewController
    {
        let name = self.storyboardNameForControllerType(type)
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        let storyboardId = type.rawValue
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId)
        return viewController
    }
    
    class func showAsRootViewController(_ type: ViewControllerType)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController = viewControllerWithType(type)
    }
    
    //MARK: - Private func
    
    fileprivate class func storyboardNameForControllerType(_ type: ViewControllerType) -> String
    {
        switch type
        {
        default:
            return "Main"
        }
    }
}
