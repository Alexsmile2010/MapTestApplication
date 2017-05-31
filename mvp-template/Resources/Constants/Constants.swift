//
//  Constants.swift
//  brixo
//
//  Created by Vedidev on 22.03.17.
//  Copyright © 2017 VedideV. All rights reserved.
//

import Foundation

struct YELP
{
    static let clietID = "Y47mx-zm7Of57ZdN3xee4w"
    static let clientSecret = "7XWb0S949dC4tjLi4kPy6ZabFdKnU0Ckuq9BFSw9n5ldJIoQjXXwpHxPhrosAuGk"
    static let mainUrl = "https://api.yelp.com/"
    
    struct Methods {
        static let auth = "oauth2/token"
        static let search = "v3/businesses/search"
        static  let reviewsStart = "v3/businesses/"
        static let reviewsFinish = "/reviews"
    }
}






