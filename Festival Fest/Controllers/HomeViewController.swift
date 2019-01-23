//
//  HomeViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/21/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: CollectionViewSlantedLayout!
    
    
    // MARK: - Variables
    internal var covers = [[String: String]]()
    internal var names = [[String:String]]()
    
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationController?.isNavigationBarHidden = true
        collectionViewLayout.isFirstCellExcluded = true
        collectionViewLayout.isLastCellExcluded = true        
        collectionViewLayout.lineSpacing = 10
    }
    
    override func loadView() {
        super.loadView()
        if let url = Bundle.main.url(forResource: "covers", withExtension: "plist"),
            let contents = NSArray(contentsOf: url) as? [[String: String]] {
            covers = contents
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



extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return covers.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSlantedCellReuseIdentifier, for: indexPath)
            as? CustomSlantedCollectionViewCell else {
                fatalError()
        }
        
        cell.image = UIImage(named: covers[indexPath.row]["picture"]!)!
        cell.title = covers[indexPath.row]["title"] ?? ""
        
        if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
            cell.contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
        }
        
        return cell
    }
}

extension HomeViewController: CollectionViewDelegateSlantedLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("Did select item at indexPath: [\(indexPath.section)][\(indexPath.row)]")
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: CollectionViewSlantedLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGFloat {
        return collectionViewLayout.scrollDirection == .vertical ? 275 : 325
    }
}

extension HomeViewController: UIScrollViewDelegate {
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
