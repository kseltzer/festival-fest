//
//  UIView+Animate.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 3/12/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Button Customization
extension UIView { // animate tapping a button (shrink then grow)
    func animateTap(scaleTo scale: CGFloat = 0.65) {
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform(scaleX: scale, y: scale)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.transform = CGAffineTransform.identity
                    })
                })
            }
        }
    }
}
