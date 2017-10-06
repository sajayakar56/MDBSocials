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
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var backgroundImage: UIImageView!
    var loginButton: UIButton!
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImages()
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
    
    // Setup Functions
    func setupImages() {
        backgroundImage = UIImageView(frame: view.frame)
        backgroundImage.image = UIImage(named: "BlurredSplash")
        backgroundImage.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
    }
    
    func setupTextFields() {
        // Username
        emailTextField = UITextField(frame: rRect(rx: 26, ry: 170, rw: 323, rh: 60))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.layoutIfNeeded()
        emailTextField.layer.cornerRadius = 30
        emailTextField.textColor = UIColor.white
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.spellCheckingType = .no
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        emailTextField.backgroundColor = Constants.mutedBlue
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        emailTextField.layer.opacity = 0.4
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        view.addSubview(emailTextField)
        
        // Password
        passwordTextField = UITextField(frame: rRect(rx: 26, ry: 265, rw: 323, rh: 60))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.layoutIfNeeded()
        passwordTextField.layer.cornerRadius = 30
        passwordTextField.textColor = UIColor.white
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.spellCheckingType = .no
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        passwordTextField.backgroundColor = Constants.mutedBlue
        passwordTextField.layer.opacity = 0.4
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        view.addSubview(passwordTextField)
    }
    
    func setupButtons() {
        loginButton = UIButton(frame: rRect(rx: 26, ry: 379, rw: 323, rh: 60))
        loginButton.layoutIfNeeded()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.cornerRadius = 30
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        loginButton.backgroundColor = UIColor(red:0.00, green:0.54, blue:1.00, alpha:1.0) // #0089FF
        view.addSubview(loginButton)
        
        backButton = UIButton(frame: CGRect(x: 11, y: 30, width: 68, height: 68))
        backButton.setImage(UIImage(named: "homeButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
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
    func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
