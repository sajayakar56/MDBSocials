//
//  SplashViewController.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 10/5/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//  The first screen the user sees

import UIKit

class SplashViewController: UIViewController {
    var backgroundImage: UIImageView!
    var logoImage: UIImageView!
    var createAccountButton: UIButton!
    var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupImages()
        setupButtons()
    }
    
    // Setup Functions
    func setupImages() {
        backgroundImage = UIImageView(frame: view.frame)
        backgroundImage.image = UIImage(named: "Splash")
        backgroundImage.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        
        logoImage = UIImageView(frame: rRect(rx: 16, ry: 169, rw: 344, rh: 180))
        logoImage.image = UIImage(named: "Logo")
        logoImage.contentMode = .scaleAspectFit
        view.addSubview(logoImage)
    }
    
    func setupButtons() {
        createAccountButton = UIButton(frame: rRect(rx: 25, ry: 593, rw: 180, rh: 30))
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(UIColor.white, for: .normal)
        createAccountButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        view.addSubview(createAccountButton)
        
        signInButton = UIButton(frame: rRect(rx: 263, ry: 593, rw: 85, rh: 30))
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(UIColor.white, for: .normal)
        signInButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        view.addSubview(signInButton)
    }
    
    // Selectors
    @objc
    func createAccountButtonPressed() {
        self.performSegue(withIdentifier: "toSignup", sender: self)
    }
    
    @objc
    func signInButtonPressed() {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
}
