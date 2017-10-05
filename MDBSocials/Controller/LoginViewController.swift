//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/24/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    var appTitle: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hue: 0.5361, saturation: 0.84, brightness: 0.87, alpha: 1.0)
        
        setupTitle()
        setupTextFields()
        setupButtons()
        
        if Auth.auth().currentUser != nil {
            userLoggedIn()
        }
    }
    
    // Transition Functions
    func userLoggedIn() {
        performSegue(withIdentifier: "loginToFeed", sender: self)
    }
    
    // View Setup Functions
    func setupTitle() {
        appTitle = UILabel(frame: rRect(rx: 54, ry: 186,
                                         rw: 268, rh: 55))
        appTitle.text = "MDB Socials"
        appTitle.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(rawValue: 3))
        appTitle.adjustsFontSizeToFitWidth = true
        appTitle.textAlignment = .center
        view.addSubview(appTitle)
    }
    
    func setupTextFields() {
        // Username
        emailTextField = UITextField(frame: rRect(rx: 20, ry: 251, rw: 336, rh: 56))
        emailTextField.placeholder = "Email"
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.layoutIfNeeded()
//        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
//        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = 12
        emailTextField.textColor = UIColor.black
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.spellCheckingType = .no
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        emailTextField.backgroundColor = UIColor.white
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        view.addSubview(emailTextField)
        
        // Password
        passwordTextField = UITextField(frame: rRect(rx: 20, ry: 307, rw: 336, rh: 56))
        passwordTextField.placeholder = "Password"
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.layoutIfNeeded()
//        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
//        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.textColor = UIColor.black
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.spellCheckingType = .no
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        passwordTextField.backgroundColor = UIColor.white
        view.addSubview(passwordTextField)
    }
    
    func setupButtons() {
        loginButton = UIButton(frame: rRect(rx: 19, ry: 381, rw: 336, rh: 54))
        loginButton.layoutIfNeeded()
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.cornerRadius = 12
        loginButton.layer.borderColor = UIColor.blue.cgColor
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        // change this to a slightly different blue
        loginButton.backgroundColor = UIColor(hue: 0.5556, saturation: 0.85, brightness: 1, alpha: 1.0) /* #24b3ff */
        view.addSubview(loginButton)
        
        signupButton = UIButton(frame: rRect(rx: 20, ry: 512, rw: 336, rh: 54))
        signupButton.layoutIfNeeded()
        signupButton.setTitle("Sign up with email", for: .normal)
        signupButton.layer.borderWidth = 2.0
        signupButton.layer.cornerRadius = 12
        signupButton.layer.borderColor = UIColor.red.cgColor
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        signupButton.backgroundColor = UIColor(hue: 0, saturation: 0.59, brightness: 0.94, alpha: 1.0) /* #f16262 */
        view.addSubview(signupButton)
    }
    
    // Selectors
    @objc
    func loginButtonClicked() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
                warning(message: "Invalid input!")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                self.userLoggedIn()
            } else {
                self.warning(message: error.debugDescription)
            }
        }
    }
    
    @objc
    func signupButtonClicked() {
        performSegue(withIdentifier: "toSignupVC", sender: self)
    }
}
