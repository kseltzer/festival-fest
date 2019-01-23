//
//  UIButton+UI.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/22/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import Foundation
import UIKit

class RoundedCornersButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.height / 2.0
    }
}
