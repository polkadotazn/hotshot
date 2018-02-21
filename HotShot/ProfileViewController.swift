//
//  ProfileViewController.swift
//  HotShot
//
//  Created by Emmanuel Feygelson on 2/20/18.
//  Copyright © 2018 Karan Cheema. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = Auth.auth().currentUser  {
            // User is signed in.
            
            usernameLabel.text = currentUser.displayName
            // ...
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    

 

}
