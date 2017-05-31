//
//  InfoWindowView.swift
//  mvp-template
//
//  Created by Vedidev on 26/05/17.
//  Copyright © 2017 Vedidev. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class InfoWindowView: UIView {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratingStarView: SwiftyStarRatingView!
    @IBOutlet var addressLabel: UILabel!
    
    

    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }

}

extension UIView
{
    class func fromNib<T : UIView>() -> T
    {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
