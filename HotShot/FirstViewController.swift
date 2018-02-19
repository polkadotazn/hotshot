//
//  FirstViewController.swift
//  HotShot
//
//  Created by Bryce Williams on 2/18/18.
//  Copyright © 2018 Bryce Williams. All rights reserved.
//

import UIKit
import FacebookLogin


class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewDidLoad() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }
    
    func viewDidLoad() {
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
        }
    }


}

