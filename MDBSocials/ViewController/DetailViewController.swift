//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/24/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    var post: Post?
    var eventName: UILabel!
    var eventImage: UIImageView!
    var eventPoster: UILabel!
    var eventInterested: UILabel!
    var eventDescription: UILabel!
    var interestedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImage()
        setupLabels()
        setupButtons()
        
        if let p = post {
            eventDescription.text = p.description
            eventInterested.text = String(p.interestedNumber) + " interested"
            eventName.text = p.eventName
            eventPoster.text = "Posted by: " + p.posterName
            p.getImage(withBlock: { img in
                self.eventImage.image = img
            })
        }
    }
    
    func setupImage() {
        eventImage = UIImageView(frame: rRect(rx: 86, ry: 162, rw: 203, rh: 203))
        eventImage.contentMode = .scaleAspectFit
        eventImage.clipsToBounds = true
        eventImage.image = UIImage(named: "placeholder")
        view.addSubview(eventImage)
    }
    
    func setupLabels() {
        eventName = UILabel(frame: rRect(rx: 0, ry: 89, rw: 375, rh: 48))
        eventName.textColor = UIColor.black
        eventName.text = "Name of Event"
        eventName.font = UIFont(name: "Helvetica", size: 36)
        eventName.textAlignment = .center
        eventName.adjustsFontSizeToFitWidth = true
        view.addSubview(eventName)
        
        eventInterested = UILabel(frame: rRect(rx: 215, ry: 372, rw: 90, rh: 24))
        eventInterested.textColor = UIColor.black
        eventInterested.text = "0 interested"
        eventInterested.font = UIFont(name: "HelveticaNeue-Italic", size: 18)
        eventInterested.adjustsFontSizeToFitWidth = true
        view.addSubview(eventInterested)
        
        eventPoster = UILabel(frame: rRect(rx: 29, ry: 403, rw: 149, rh: 27))
        eventPoster.textColor = UIColor.black
        eventPoster.text = "Posted by: Name"
        eventPoster.font = UIFont(name: "Helvetica", size: 20)
        eventPoster.adjustsFontSizeToFitWidth = true
        view.addSubview(eventPoster)
        
        eventDescription = UILabel(frame: rRect(rx: 29, ry: 443, rw: 299, rh: 48))
        eventDescription.textColor = UIColor.black
        eventDescription.text = "Brief description about the event that says important stuff about it haha"
        eventDescription.font = UIFont(name: "Helvetica", size: 18)
        eventDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventDescription.numberOfLines = 0
        view.addSubview(eventDescription)
    }
    
    func setupButtons() {
        interestedButton = UIButton(frame: rRect(rx: 54, ry: 559, rw: 267, rh: 70))
        interestedButton.backgroundColor = UIColor(red: 1.00, green: 0.91, blue: 0.59, alpha: 1.0) // #ffe797
        interestedButton.setTitle("Interested?", for: .normal)
        interestedButton.addTarget(self, action: #selector(interestedButtonPressed), for: .touchUpInside)
        view.addSubview(interestedButton)
    }
    
    @objc
    func interestedButtonPressed() {
    }
}

