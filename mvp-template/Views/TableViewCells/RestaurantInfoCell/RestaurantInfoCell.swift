//
//  RestaurantInfoCell.swift
//  mvp-template
//
//  Created by Vedidev on 29.05.17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import UIKit
import SwiftyStarRatingView
import Nuke

class RestaurantInfoCell: UITableViewCell
{
    //MARK: - IBA
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var raitingView: SwiftyStarRatingView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(restaurant: Restaurant)
    {
        self.nameLabel.text = "Name: \(restaurant.name)"
        self.adressLabel.text = "Adress: \(restaurant.address)"
        self.categoryLabel.text = "Category: \(restaurant.categories)"
        
        self.raitingView.value = CGFloat(restaurant.rating)
        
        Nuke.loadImage(with: URL(string: restaurant.imageUrl)!, into: self.mainImageView) {
            [weak self] responce, _ in
            self?.mainImageView.image = responce.value
        }
    }
}

