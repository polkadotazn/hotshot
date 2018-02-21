//
//  ViewController.swift
//  HotShot
//
//  Created by Karan Cheema on 2/19/18.
//  Copyright © 2018 Karan Cheema. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
   
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        // use constraints instead
//        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 80, height: 50 )
        
        
        view.addSubview(loginButton)
        
        loginButton.delegate = self
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Successfully logged in with Facebook")
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
    
    @IBAction func facebookLogin(sender: LoginButton) {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                else {
                    self.performSegue(withIdentifier: "goHome", sender: self)
                }
                
                // Present the main view
             
                
            })
            
        }
    }
}

