//
//  ViewController.swift
//  HotShot
//
//  Created by Karan Cheema on 2/19/18.
//  Copyright © 2018 Karan Cheema. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class AuthenticationController: UIViewController {

    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
//    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var userPassError: UILabel!
    
    
    var isSignIn:Bool = true
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameLabel.isHidden = true
        usernameTextField.isHidden = true
        emailError.isHidden = true
        passwordError.isHidden = true
        userPassError.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        emailError.isHidden = true
        passwordError.isHidden = true
        userPassError.isHidden = true
        emailTextField.text = ""
        passwordTextField.text = ""
        usernameTextField.text = ""
        
        
        isSignIn = !isSignIn
        
        if isSignIn {
            usernameLabel.isHidden = true
            usernameTextField.isHidden = true
//            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            usernameLabel.isHidden = false
            usernameTextField.isHidden = false
//            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
        
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        // Still need to do form validation here
        
        if let email = emailTextField.text, let pass = passwordTextField.text, let username = usernameTextField.text
        {
            if isSignIn {
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                    if user != nil {
                        user?.createProfileChangeRequest()
                        
//                        user.setDisplayName(username)
                        // go to homescreen
                        self.performSegue(withIdentifier: "goHome", sender: self)
                        
                    }
                    else {
                        self.userPassError.isHidden = false
                        // check error and show message
                    }
                })
            }
            else {
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                    if user != nil {
                        let setUsername = Auth.auth().currentUser?.createProfileChangeRequest()
                        setUsername?.displayName = username
                        setUsername?.commitChanges()
                        
                        // go to homescreen
                        self.performSegue(withIdentifier: "goHome", sender: self)
                    }
                    else {
                        if (pass.count < 6) {
                            self.passwordError.isHidden = false
                        } else {
                            self.emailError.isHidden = false
                        }
                        // check error and show message
                    }
                })
            }
        }
        
       
        
    }
}

