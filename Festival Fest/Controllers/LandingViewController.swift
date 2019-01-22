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
    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet var blurViews: [UIVisualEffectView]!
    
    @IBOutlet var buttonViews: [UIView]!
    
    
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sway background
        UIView.animate(withDuration: 6.5, delay: 0, options: [.repeat, .autoreverse, .curveLinear], animations: {
            self.bgView.frame.origin.x = self.view.frame.origin.x + 30
        }, completion: nil)

        // round buttons
        for blurView in blurViews {
            blurView.roundCorners()
        }
    }
    
    
    // MARK: - Actions
    @IBAction func proceedTapped(_ sender: Any) {
        navigateToHomeScreen()
    }
    
    
    // MARK: - Navigation
    func navigateToHomeScreen() {
        let menuVC = UIStoryboard(name: kMainStoryboard, bundle: nil).instantiateViewController(withIdentifier: kMenuViewController) as! MenuViewController
        present(menuVC, animated: true, completion: nil)
    }

}

extension UIView {
    func roundCorners() {
        layer.cornerRadius = bounds.height / 2.0
    }
}
