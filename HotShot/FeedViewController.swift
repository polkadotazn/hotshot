//
//  FeedViewController.swift
//  HotShot
//
//  Created by Emmanuel Feygelson on 2/20/18.
//  Copyright © 2018 Karan Cheema. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import GoogleMaps
import GooglePlaces

class FeedViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, CLLocationManagerDelegate , GMSMapViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell";
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath)
        
        cell.textLabel?.text = "TEST"
        
        return cell;
    }
    

        
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storageRef = Storage.storage().reference()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        let islandRef = storageRef.child("mountains.mov")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 1000 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error")
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                print(data!)
            }
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var isHot = true
    
    
    @IBAction func hotNewSelectorChanged(_ sender: UISegmentedControl) {
        isHot = !isHot
    }
    

}
