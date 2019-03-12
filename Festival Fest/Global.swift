//
//  Global.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/21/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Storyboard Ids

// Storyboards
let kMainStoryboard = "Main"
let kLineupStoryboard = "Lineup"
let kScheduleStoryboard = "Schedule"
let kMapStoryboard = "Map"
let kFAQStoryboard = "FAQ"
let kContactStoryboard = "Contact"
let kAboutStoryboard = "About"

// View Controllers
let kMenuViewController = "MenuViewController"
let kLineupViewController = "LineupViewController"
let kConversationViewController = "ConversationViewController"
let kScheduleViewController = "ScheduleViewController"
let kMapViewController = "MapViewController"
let kFAQViewController = "FAQViewController"
let kContactViewController = "ContactViewController"
let kAboutViewController = "AboutViewController"

// Cells
let kSlantedCellReuseIdentifier = "customViewCell"
let kEventCell = "EventCell"
let kQACell = "QACell"
let kAboutCell = "AboutCell"


// MARK: - Phone Type
var phoneType: PhoneType = .x
enum PhoneType: CGFloat { // float = screen height
    case six = 1334 // 6, 6s, 7, 8
    case sixPlus = 2208
    case x = 2436 // x and xs
    case xr = 1792
    case xsMax = 2688
    case se = 1136
    
    func height() -> CGFloat {
        return rawValue
    }
}
