//
//  ResponseHandler.swift
//  Cravepal
//
//  Created by Vedidev on 26.04.16.
//  Copyright © 2016 Vedidev. All rights reserved.
//

enum ResponseError: Error
{
    case keyNotFond(String)
    case errorMessage(String)
    case fatalError
    
}

public enum ResponceErrorType
{
    case errorTypeNone
    case errorTypeMessage(String)
    case errorTypeInvalidAccessToken
    case errorTypeInvalidUser
}

import Foundation
import JSONJoy

open class ResponseHandler
{
    fileprivate(set) fileprivate var json: JSONDecoder!
    
    open var success : Bool = false
    open var response: Any?
    open var error: Error?
    open var statusCode: Int! = 0
    open var model: RequestModel!
    open var completionBlock:((_ response: ResponseHandler, _ error: Error?) -> Void)?
    
    open func decodeRequest()
    {
        do{
           try self.validateResponse()
        }
        catch ResponseError.fatalError
        {
            if self.completionBlock != nil
            {
                self.completionBlock!(self, ResponseError.fatalError)
            }
        }
        catch ResponseError.keyNotFond(let message)
        {
            if self.completionBlock != nil
            {
                self.completionBlock!(self, ResponseError.keyNotFond(message))
            }
        }
        catch ResponseError.errorMessage(let message)
        {
            if self.completionBlock != nil
            {
                self.completionBlock!(self, ResponseError.errorMessage(message))
            }
        }
        catch
        {
            print("Unknow Error")
        }
    }
    
    fileprivate func parseJSON(_ json: JSONDecoder) throws {}
}

//MARK: - Private

fileprivate extension ResponseHandler
{
    ///Func check response json and return type of action
    fileprivate func validateResponse() throws
    {
        switch self.statusCode
        {
        case 200...300:
            
            self.json = JSONDecoder(self.response!)
            
            do{
                try self.parseJSON(self.json)
                
                if self.completionBlock != nil
                {
                    self.completionBlock!(self, nil)
                }
            }
            catch ResponseError.keyNotFond(let message)
            {
                throw ResponseError.keyNotFond(message)
            }
            catch ResponseError.errorMessage(let message)
            {
                throw ResponseError.errorMessage(message)
            }
            catch
            {
                throw ResponseError.fatalError
            }
            
            break;
            
        case 400...404:
            
            self.json = JSONDecoder(self.response!)
            
            guard let message:String = try json["message"].get() , message.characters.count != 0 else
            {
                throw ResponseError.fatalError
            }
            
            throw ResponseError.errorMessage(message)
            
        case 500:
            
            throw ResponseError.fatalError
            
        default:
            
            throw ResponseError.fatalError
        }
    }
}

class AccessTokenHandler: ResponseHandler {
    var accessToken: String = ""
    
    public override init()
    {
        super.init()
    }
    
    open override func parseJSON(_ json: JSONDecoder) throws
    {
        do{
            self.accessToken = try json["access_token"].get()
        }
        catch JSONError.wrongType
        {
            throw ResponseError.errorMessage("\(self): key STATUS contains FALSE")
        }
        catch
        {
            throw ResponseError.fatalError
        }
    }
    
}

class RestauransHandler: ResponseHandler {
    var restaurants: [Restaurant] = []
    
    public override init()
    {
        super.init()
    }
    
    open override func parseJSON(_ json: JSONDecoder) throws
    {
        do {
            let businesses:[JSONDecoder] = try json["businesses"].get()
            for business in businesses {
                try restaurants.append(Restaurant(business))
            }
        }
        catch JSONError.wrongType
        {
            throw ResponseError.errorMessage("\(self): key STATUS contains FALSE")
        }
        catch
        {
            throw ResponseError.fatalError
        }
    }
}

class ReviewsHadler: ResponseHandler {
    var reviews: [Review] = []
    
    public override init()
    {
        super.init()
    }
    
    open override func parseJSON(_ json: JSONDecoder) throws
    {
        do {
            let docoderReviews:[JSONDecoder] = try json["reviews"].get()
            for review in docoderReviews {
                try reviews.append(Review(review))
            }
        }
        catch JSONError.wrongType
        {
            throw ResponseError.errorMessage("\(self): key STATUS contains FALSE")
        }
        catch
        {
            throw ResponseError.fatalError
        }
    }
}


