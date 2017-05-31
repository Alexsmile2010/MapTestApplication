//
//  AuthManager.swift
//  mvp-template
//
//  Created by Vedidev on 29.05.17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import Foundation

typealias GetAuthTokenHandler = (_ accessToken: String) -> Swift.Void

class AuthManager
{
    //MARK: - LER
    static let shared = AuthManager()

    //MARK: - VAR
    private var accessToken: String?
    
    //MARK: - INIT
    private init() {}

    
    open func getAuthToken(handler: GetAuthTokenHandler?)
    {
        if self.accessToken == nil
        {
            let authModel = AuthRequestModel()
            RequestManager.addRequest(authModel).runWithHandler(AccessTokenHandler()) {[weak self] (responce, error) in
               
                guard error == nil else {
                    self?.accessToken = nil
                    return
                }
                
                self?.accessToken = responce?.accessToken
                
                handler!((self?.accessToken)!)
            }
        }
        else
        {
            handler!(self.accessToken!)
        }
    }
    
}
