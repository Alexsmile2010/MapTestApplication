//
//  AuthRequestModel.swift
//  mvp-template
//
//  Created by Vedidev on 26/05/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import Foundation

class AuthRequestModel: RequestModel {
    
    override init() {
        super.init()
        self.requestMethod = REQUEST_METHOD.post
    }
    
    override func finalizeParams() {
        self.mainURL = YELP.mainUrl + YELP.Methods.auth
        self.bodyData = ["grant_type": "client_credentials", "client_id": YELP.clietID, "client_secret": YELP.clientSecret]
    }
    
}
