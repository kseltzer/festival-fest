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
    @IBOutlet var proceedButtons: [UIButton]!
    

    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()

        // round buttons
        for button in proceedButtons {
            button.roundCorners()
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
