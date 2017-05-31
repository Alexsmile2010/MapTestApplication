//
//  RestauransRequestModel.swift
//  mvp-template
//
//  Created by Vedidev on 26/05/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import Foundation
import CoreLocation

class RestaurantsRequestModel: RequestModel {
    var location: CLLocation!
    var auth: String!
    var offset: Int = 0
    var radius: Int = 0
    var limit: Int = 50
    
    init(location: CLLocation, auth: String, radius: Int, offset: Int, limit: Int) {
        super.init()
        self.requestMethod = REQUEST_METHOD.get
        self.auth = auth
        self.location = location
        self.offset = offset
        self.radius = radius
    }
    
    override func finalizeParams() {
        self.mainURL = YELP.mainUrl + YELP.Methods.search + "?term=restaurants&latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&radius=\(radius)&offset=\(offset)&limit=\(limit)"
        self.bodyData = ["Authorization": "Bearer \(auth!)",
        "Accept": "application/json"]
    }
}
