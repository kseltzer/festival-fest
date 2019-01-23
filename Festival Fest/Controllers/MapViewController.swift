//
//  MapViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/22/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit
import ZoomImageView

class MapViewController: UIViewController {
    
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView: ZoomImageView = ZoomImageView(image: UIImage(named: "map")!)
        imageView.frame = CGRect(x: -2, y: 132, width: view.frame.width + 4, height: view.frame.height - 152)
        view.addSubview(imageView)
    }

}
