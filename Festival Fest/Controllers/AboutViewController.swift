//
//  AboutViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 3/11/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: kAboutCell) ?? UITableViewCell()
    }
}
