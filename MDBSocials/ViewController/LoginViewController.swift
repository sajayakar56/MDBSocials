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
    // thanks vidya for the great variable names
    var appTitle: UILabel!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // replace this with a picture
        view.backgroundColor = UIColor(hue: 0.5361, saturation: 0.84, brightness: 0.87, alpha: 1.0)
        
        setupTitle()
        setupTextFields()
        setupButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // View Setup Functions
    func setupTitle() {
        appTitle = UILabel(frame: CGRect(x: 54, y: 186,
                                         width: 268, height: 55))
        appTitle.text = "MDB Socials"
        appTitle.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(rawValue: 3))
        appTitle.adjustsFontSizeToFitWidth = true
        appTitle.textAlignment = .center
        view.addSubview(appTitle)
    }
    
    func setupTextFields() {
        // Username
        usernameTextField = UITextField(frame: CGRect(x: 20, y: 251, width: 336, height: 56))
        usernameTextField.placeholder = "Username"
        usernameTextField.adjustsFontSizeToFitWidth = true
        usernameTextField.layoutIfNeeded()
//        usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
//        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.cornerRadius = 12
        usernameTextField.textColor = UIColor.black
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        usernameTextField.spellCheckingType = .no
        usernameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        usernameTextField.backgroundColor = UIColor.white
        view.addSubview(usernameTextField)
        
        // Password
        passwordTextField = UITextField(frame: CGRect(x: 20, y: 307, width: 336, height: 56))
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
        loginButton = UIButton(frame: CGRect(x: 19, y: 381, width: 336, height: 54))
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
        
        signupButton = UIButton(frame: CGRect(x: 20, y: 512, width: 336, height: 54))
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
        print("Login!")
    }
    
    @objc
    func signupButtonClicked() {
        performSegue(withIdentifier: "toSignupVC", sender: self)
    }
}
