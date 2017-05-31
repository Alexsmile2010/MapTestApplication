//
//  Review.swift
//  mvp-template
//
//  Created by Vedidev on 29/05/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import Foundation
import JSONJoy

class Review: JSONJoy {
    var rating: Double
    var image_url: String
    var name: String
    var text: String
    var time_created: String
    var url: String
    
    required init(_ decoder: JSONDecoder) throws {
        self.rating = try decoder["rating"].get()
        self.image_url = try decoder["user"]["image_url"].get()
        self.name = try decoder["user"]["name"].get()
        self.text = try decoder["text"].get()
        self.time_created = try decoder["time_created"].get()
        self.url = try decoder["url"].get()
    }
}
