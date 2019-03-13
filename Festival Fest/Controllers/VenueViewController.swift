//
//  VenueViewController.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 3/12/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import UIKit
import MapKit

class VenueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Outlets
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adjust vertical positioning
        switch phoneType {
        case .six:
            contentViewTopConstraint.constant = 132
        case .xr, .xsMax, .x:
            contentViewTopConstraint.constant = 160
        default:
            break
        }
        
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
        return tableView.dequeueReusableCell(withIdentifier: kVenueCell) ?? UITableViewCell()
    }
    
    
    // MARK: - Actions
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.animateTap()
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.1) {
            self.openMapForPlace()
        }
    }
    
    func openMapForPlace() {
        let latitude: CLLocationDegrees = 34.044557
        let longitude: CLLocationDegrees = -118.2375141
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "The Hub"
        mapItem.openInMaps(launchOptions: options)
    }
}
