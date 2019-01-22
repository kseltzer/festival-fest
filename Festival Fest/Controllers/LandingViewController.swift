//
//  LandingViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/21/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var blurViews: [UIVisualEffectView]!
    
    @IBOutlet var buttonViews: [UIView]!
    
    
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()

        // round buttons
        for blurView in blurViews {
            blurView.roundCorners()
        }
        
        for buttonView in buttonViews {
            buttonView.roundCorners()
        }
    }
    
    
    // MARK: - Actions
    @IBAction func proceedTapped(_ sender: Any) {
        navigateToHomeScreen()
    }
    
    
    // MARK: - Navigation
    func navigateToHomeScreen() {
        
    }

}

extension UIView {
    func roundCorners() {
        layer.cornerRadius = bounds.height / 2.0
    }
}
