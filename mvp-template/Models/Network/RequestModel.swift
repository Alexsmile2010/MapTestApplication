//
//  RequestModel.swift
//  VARGapp
//
//  Created by Vedidev on 06.07.16.
//  Copyright © 2016 Vedidev. All rights reserved.
//

import Foundation
import Alamofire


public enum REQUEST_METHOD: String
{
    case get, post
}


open class RequestModel
{
    //This is main url for request. It can be changed anywere at all sublass
    var mainURL =  YELP.mainUrl {
        didSet {
            assert(!mainURL.contains("Optional"), "FOUND OPTIONAL in mainURL \(type(of: self)) ")
        }
    }
    
    var bodyData: [String : String] = [String : String]()
    
    var requestMethod: REQUEST_METHOD?
    
    //Bool instance for setting showing progress when request is run
    var showProgress: Bool = true
    
    //Base Init class
    init() {}
    
    //Overrife func for generete body for request
    open func finalizeParams(){}
}


