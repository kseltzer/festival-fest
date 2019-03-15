//
//  TicketsViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 3/12/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit

class TicketsViewController: UIViewController, UIActivityItemSource {

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
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        }
    }

    @IBAction func shareTapped(_ sender: UIButton) {
        sender.animateTap()
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.1) {
            self.share()
        }
    }
    
    func share() {
        let items = ["Do you know about Festival Fest? I'm confused by it"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        let tweet = "Twitter's algorithm is messing up our feeds. RT this and go to Festival Fest to fix your feed"
        let text = "Do you know about Festival Fest? I'm confused by it"
        let note = "✔︎ Remember to get tickets for Festival Fest.\n✔︎ Remember to take a sec for myself.\n✔︎ Remember to only accept the compliments I've earned."
        let email = "Forward this to everyone you know."

        if let activityType = activityType {
            switch activityType {
            case .postToTwitter:
                return tweet
            case .mail:
                return email
            case .postToFacebook:
                return text
            default:
                return text
            }
        }
        
        if activityType == .postToTwitter {
            return tweet
        } else {
            return "Download MyAwesomeApp from TwoStraws."
        }
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "Festival Fest"
    }
}
