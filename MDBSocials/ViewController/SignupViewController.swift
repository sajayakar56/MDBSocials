//
//  SignupViewController.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/24/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
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

    
    // Setup Functions
    func setupTitle() {
        screenTitle = UILabel(frame: rRect(rx: 202, ry: 30, rw: 151, rh: 55))
        screenTitle.text = "Signup"
        screenTitle.font = UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(rawValue: 3))
        screenTitle.adjustsFontSizeToFitWidth = true
        screenTitle.textAlignment = .center
        view.addSubview(screenTitle)
    }
    
    func setupTextFields() {
        nameTextField = UITextField(frame: rRect(rx: 27, ry: 132, rw: 210, rh: 34))
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
        
        passwordTextField = UITextField(frame: rRect(rx: 27, ry: 204, rw: 210, rh: 34))
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
        
        emailTextField = UITextField(frame: rRect(rx: 27, ry: 276, rw: 210, rh: 34))
        emailTextField.layer.backgroundColor = UIColor.lightGray.cgColor
        emailTextField.placeholder = "Email"
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.layoutIfNeeded()
        emailTextField.layer.cornerRadius = 2
        emailTextField.textColor = UIColor.black
        emailTextField.autocorrectionType = .no
        emailTextField.spellCheckingType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        view.addSubview(emailTextField)
    }
    
    func setupButtons() {
        backButton = UIButton(frame: rRect(rx: 27, ry: 38, rw: 40, rh: 40))
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(backButton)
        
        signupButton = UIButton(frame: rRect(rx: 17, ry: 360, rw: 336, rh: 54))
        signupButton.setTitle("Register", for: .normal)
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        signupButton.backgroundColor = UIColor.lightGray
        view.addSubview(signupButton)
    }
    
    // Selectors
    @objc
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func signupButtonClicked() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let name = nameTextField.text else {
                warning(message: "Not all fields are valid!")
                return
        }
        // consider making a class to handle this
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                let ref = Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!)
                // still not storing image
                ref.setValue(["name": name, "email": email, "imageUrl": ""])
                self.goBack()
            } else {
                self.warning(message: error.debugDescription)
            }
        })
    }
}
