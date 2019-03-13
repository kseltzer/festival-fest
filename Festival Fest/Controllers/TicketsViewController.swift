//
//  TicketsViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 3/12/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit

class TicketsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var contentViewTopLayoutConstraint: NSLayoutConstraint!
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adjust vertical positioning
        switch phoneType {
        case .six:
            contentViewTopLayoutConstraint.constant = 132
        case .xr, .xsMax, .x:
            contentViewTopLayoutConstraint.constant = 160
        default:
            break
        }
    }
    
    
    // MARK: - Actions
    @IBAction func getTicketsButtonTapped(_ sender: UIButton) {
        sender.animateTap()
        openTicketLink()
    }
    
    func openTicketLink() {
        guard let url = URL(string: "https://thebestfriendsshow.ticketleap.com/festival-fest/dates/Mar-23-2019_at_0800PM") else { return }
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.1) {            
            UIApplication.shared.open(url)
        }
    }

}
