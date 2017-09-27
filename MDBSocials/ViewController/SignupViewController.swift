//
//  SignupViewController.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/24/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var screenTitle: UILabel!
    var backButton: UIButton!
    var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupTextFields()
        setupButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Setup Functions
    func setupTitle() {
        screenTitle = UILabel(frame: CGRect(x: 202, y: 30, width: 151, height: 55))
        screenTitle.text = "Signup"
        screenTitle.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(rawValue: 3))
        screenTitle.adjustsFontSizeToFitWidth = true
        screenTitle.textAlignment = .center
        view.addSubview(screenTitle)
    }
    
    func setupTextFields() {
        nameTextField = UITextField(frame: CGRect(x: 27, y: 132, width: 210, height: 34))
        nameTextField.layer.backgroundColor = UIColor.lightGray.cgColor
        nameTextField.placeholder = "Name"
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.layoutIfNeeded()
        nameTextField.layer.cornerRadius = 2
        nameTextField.textColor = UIColor.black
        nameTextField.autocorrectionType = .no
        nameTextField.spellCheckingType = .no
        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        view.addSubview(nameTextField)
        
        usernameTextField = UITextField(frame: CGRect(x: 27, y: 204, width: 210, height: 34))
        usernameTextField.layer.backgroundColor = UIColor.lightGray.cgColor
        usernameTextField.placeholder = "Username"
        usernameTextField.adjustsFontSizeToFitWidth = true
        usernameTextField.layoutIfNeeded()
        usernameTextField.layer.cornerRadius = 2
        usernameTextField.textColor = UIColor.black
        usernameTextField.autocorrectionType = .no
        usernameTextField.spellCheckingType = .no
        usernameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        view.addSubview(usernameTextField)
        
        passwordTextField = UITextField(frame: CGRect(x: 27, y: 276, width: 210, height: 34))
        passwordTextField.layer.backgroundColor = UIColor.lightGray.cgColor
        passwordTextField.placeholder = "Password"
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.layoutIfNeeded()
        passwordTextField.layer.cornerRadius = 2
        passwordTextField.textColor = UIColor.black
        passwordTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.spellCheckingType = .no
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        view.addSubview(passwordTextField)
        
        emailTextField = UITextField(frame: CGRect(x: 27, y: 348, width: 210, height: 34))
        emailTextField.layer.backgroundColor = UIColor.lightGray.cgColor
        emailTextField.placeholder = "Email"
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.layoutIfNeeded()
        emailTextField.layer.cornerRadius = 2
        emailTextField.textColor = UIColor.black
        emailTextField.autocorrectionType = .no
        emailTextField.spellCheckingType = .no
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        view.addSubview(emailTextField)
    }
    
    func setupButtons() {
        backButton = UIButton(frame: CGRect(x: 27, y: 38, width: 40, height: 40))
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    // Selectors
    @objc
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
