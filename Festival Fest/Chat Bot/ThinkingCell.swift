//
//  ThinkingCell.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/22/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit

// Used to indicate that the bot is "thinking". It contains a single image view which can be animated.
class ThinkingCell: UITableViewCell {
    
    @IBOutlet weak var thinkingImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        thinkingImage.animationImages = (1...3).map {
            index in
            return UIImage(named: "thinking\(index)")!
        }
        thinkingImage.animationDuration = 1
    }
    
    
}
