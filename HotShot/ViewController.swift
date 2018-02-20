//
//  ViewController.swift
//  HotShot
//
//  Created by Karan Cheema on 2/19/18.
//  Copyright © 2018 Karan Cheema. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        isSignIn = !isSignIn
        
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
        
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        // Still need to do form validation here
        
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            if isSignIn {
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                    if user != nil {
                        // go to homescreen
                        self.performSegue(withIdentifier: "goHome", sender: self)
                    }
                    else {
                        // check error and show message
                    }
                })
            }
            else {
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                    print("test")
                    if user != nil {
                         print("test0")
                        // go to homescreen
                        self.performSegue(withIdentifier: "goHome", sender: self)
                    }
                    else {
                        // check error and show message
                    }
                })
            }
        }
        
       
        
    }
}

