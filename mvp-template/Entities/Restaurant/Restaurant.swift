//
//  Restaurant.swift
//  mvp-template
//
//  Created by Vedidev on 29/05/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import Foundation
import JSONJoy


class Restaurant: JSONJoy{
    var imageUrl: String
    var name: String
    var phoneNumber: String
    var categories: String = ""
    var rating: Double
    var longtitude: Double
    var latitude: Double
    var address: String
    var id: String
    
    required init(_ decoder: JSONDecoder) throws {
        self.imageUrl = try decoder["image_url"].get()
        self.name =  try decoder["name"].get()
        self.phoneNumber =  try decoder["phone"].get()
        let jsonCategories: [JSONDecoder] =  try decoder["categories"].get()
        for (index, category) in jsonCategories.enumerated() {
            self.categories += try category["title"].get()
            if jsonCategories.count < index + 1 {
                self.categories += ", "
            }
        }
        self.rating =  try decoder["rating"].get()
        self.longtitude = try decoder["coordinates"]["longitude"].get()
        self.latitude = try decoder["coordinates"]["latitude"].get()
        self.address  = try decoder["location"]["address1"].get()
        self.id = try decoder["id"].get()
    }
}
