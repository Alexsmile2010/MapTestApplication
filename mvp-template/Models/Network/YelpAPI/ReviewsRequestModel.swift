//
//  ReviewsRequestModel.swift
//  mvp-template
//
//  Created by Vedidev on 26/05/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import Foundation

class ReviewsRequestModel: RequestModel {
    private var id = ""
    private var auth: String!
    
    init(id: String, auth: String) {
        super.init()
        self.requestMethod = REQUEST_METHOD.get
        self.auth = auth
        self.id = id
    }
    
    override func finalizeParams() {
        self.mainURL = YELP.mainUrl + YELP.Methods.reviewsStart + id + YELP.Methods.reviewsFinish
        self.bodyData = ["Authorization": "Bearer \(auth!)",
            "Accept": "application/json"
        ]
    }
}
