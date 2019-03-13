//
//  ContactViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/22/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var callSenatorButtons: [RoundedCornersButton]!
    @IBOutlet weak var contactFestButton: RoundedCornersButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adjust vertical positioning
        switch phoneType {
        case .six:
            contentViewTopConstraint.constant = 132
        case .xr, .xsMax, .x:
            contentViewTopConstraint.constant = 184
        default:
            break
        }
    }
    
    
    // MARK: - Actions
    @IBAction func contactFestButtonTapped(_ sender: UIButton) {
        print("conact fest tapped")
        sender.animateTap()
        
        let email = "thebestfriendsshowla@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    

    @IBAction func callSenatorButtonTapped(_ sender: UIButton) {
        print("call senator tapped")
        sender.animateTap()
        
        let senatorHotlineNumber = "2022243121"
        guard let number = URL(string: "tel://" + senatorHotlineNumber) else { return }
        UIApplication.shared.open(number)
    }

}
