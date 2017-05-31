//
//  RestaurantDetailViewController.swift
//  mvp-template
//
//  Created by Vedidev on 26/05/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import UIKit
import Nuke
import FRStretchImageView
import SKPhotoBrowser

class RestaurantDetailViewController: BaseViewController
{
    //MARK: - IBA
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - VAR
    //MARK: OPEN
    open var restaurant: Restaurant!
    //MARK:  PRIVATE
    private var requestCount = 0
    
    
    //MARK: - LIFECIRCLE
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tableView.registerNib()
        self.tableView.rowHeight = 44
    }
}

//MARK: - UITableViewDataSource

extension RestaurantDetailViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(RestaurantInfoCell.self, for: indexPath)
        cell.setCell(restaurant: self.restaurant)
        return cell
    }
}

extension RestaurantDetailViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImageURL(self.restaurant.imageUrl)
        photo.shouldCachePhotoURLImage = false // you can use image cache by true(NSCache)
        images.append(photo)
        
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})
    }
}
