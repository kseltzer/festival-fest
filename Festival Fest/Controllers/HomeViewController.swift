//
//  HomeViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/21/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Variables
    
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure collection view
        
    }
    
    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
    // MARK: - Actions
    
    
    // MARK: - Navigation
}
