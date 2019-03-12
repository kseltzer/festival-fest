//
//  LineupViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/21/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout

class LineupViewController: UIViewController {
    
    enum ContentType {
        case lineup
        case talent
    }
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: CollectionViewSlantedLayout!
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    
    
    // MARK: - Variables
    internal var talent = [[String:String]]()
    internal var covers = [[String: String]]()
    internal var names = [[String:String]]()
    var contentType: ContentType = .talent
    
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationController?.isNavigationBarHidden = true
        collectionViewLayout.isFirstCellExcluded = true
        collectionViewLayout.isLastCellExcluded = true        
        collectionViewLayout.lineSpacing = 1
        
        switch phoneType {
        case .six:
            collectionViewTopConstraint.constant = 132
        case .xr, .xsMax, .x:
            collectionViewTopConstraint.constant = 160
        default:
            break
        }
    }
    
    override func loadView() {
        super.loadView()
        if let url = Bundle.main.url(forResource: "covers", withExtension: "plist"),
            let contents = NSArray(contentsOf: url) as? [[String: String]] {
            covers = contents
        }
        
        if let url = Bundle.main.url(forResource: "talent", withExtension: "plist"),
            let contents = NSArray(contentsOf: url) as? [[String: String]] {
            talent = contents
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.collectionView.reloadData()
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.reloadData()
        self.collectionView.performBatchUpdates(nil, completion: {
            (result) in
            // ready
            guard let collectionView = self.collectionView else { return }
            if let visibleCells = collectionView.visibleCells as? [CustomSlantedCollectionViewCell] {
                for parallaxCell in visibleCells {
                    let yOffset = (collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight
                    let xOffset = (collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth
                    parallaxCell.offset(CGPoint(x: xOffset * xOffsetSpeed, y: yOffset * yOffsetSpeed))
                }
            }
        })
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "ShowSettings" ,
//            let settingsController = segue.destination as? SettingsController,
//            let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout else {
//                return
//        }
//
//        settingsController.collectionViewLayout = layout
    }
    
    
    // MARK: - Actions
    
    
    // MARK: - Navigation
}



extension LineupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch contentType {
        case .talent:
            return talent.count
        case .lineup:
            return covers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSlantedCellReuseIdentifier, for: indexPath)
            as? CustomSlantedCollectionViewCell else {
                fatalError()
        }
        
        switch contentType {
        case .lineup:
            cell.image = UIImage(named: covers[indexPath.row]["picture"]!)!
            cell.title = covers[indexPath.row]["title"] ?? ""
            cell.subtitle = covers[indexPath.row]["subtitle"] ?? ""
        case .talent:
            cell.image = UIImage(named: talent[indexPath.row]["picture"]!)!
            cell.title = talent[indexPath.row]["name"] ?? ""
            cell.subtitle = talent[indexPath.row]["subtitle"] ?? ""
        }
        
        if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
            cell.contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
        }
        
        return cell
    }
}

extension LineupViewController: CollectionViewDelegateSlantedLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("Did select item at indexPath: [\(indexPath.section)][\(indexPath.row)]")
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: CollectionViewSlantedLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGFloat {
        return collectionViewLayout.scrollDirection == .vertical ? 275 : 325
    }
}

extension LineupViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else {return}
        guard let visibleCells = collectionView.visibleCells as? [CustomSlantedCollectionViewCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = (collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight
            let xOffset = (collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth
            parallaxCell.offset(CGPoint(x: xOffset * xOffsetSpeed, y: yOffset * yOffsetSpeed))
        }
    }
}
