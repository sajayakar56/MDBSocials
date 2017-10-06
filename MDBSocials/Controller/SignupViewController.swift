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
    var backgroundImage: UIImageView!
    var passwordTextField: UITextField!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var backButton: UIButton!
    var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImages()
        setupTextFields()
        setupButtons()
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
        nameTextField = UITextField(frame: rRect(rx: 26, ry: 125, rw: 323, rh: 60))
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.layoutIfNeeded()
        nameTextField.layer.cornerRadius = 30
        nameTextField.textColor = UIColor.white
        nameTextField.autocorrectionType = .no
        nameTextField.autocapitalizationType = .none
        nameTextField.spellCheckingType = .no
        nameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        nameTextField.backgroundColor = Constants.mutedBlue
        nameTextField.layer.opacity = 0.4
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        view.addSubview(nameTextField)
        
        emailTextField = UITextField(frame: rRect(rx: 26, ry: 213, rw: 323, rh: 60))
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
        
        passwordTextField = UITextField(frame: rRect(rx: 26, ry: 301, rw: 323, rh: 60))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.layoutIfNeeded()
        passwordTextField.layer.cornerRadius = 30
        passwordTextField.textColor = UIColor.white
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.spellCheckingType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        passwordTextField.backgroundColor = Constants.mutedBlue
        passwordTextField.keyboardType = UIKeyboardType.emailAddress
        passwordTextField.layer.opacity = 0.4
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        view.addSubview(passwordTextField)
    }
    
    func setupButtons() {
        backButton = UIButton(frame: rRect(rx: 11, ry: 30, rw: 68, rh: 68))
        backButton.setImage(UIImage(named: "homeButton"), for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(backButton)
        
        signupButton = UIButton(frame: rRect(rx: 26, ry: 405, rw: 323, rh: 60))
        signupButton.layoutIfNeeded()
        signupButton.setTitle("Register", for: .normal)
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.layer.cornerRadius = 30
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        signupButton.backgroundColor = UIColor(red: 0.00, green: 0.47, blue: 0.81, alpha: 1.0) // #0077CE
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
