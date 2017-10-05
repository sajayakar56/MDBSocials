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
    var post: Social!
    var s: State!
    var eventName: UILabel!
    var eventImage: UIImageView!
    var eventPoster: UILabel!
    var eventInterested: UILabel!
    var eventDescription: UILabel!
    var eventDate: UILabel!
    var interestedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImage()
        setupLabels()
        setupButtons()
        
        eventDescription.text = post.description
        eventInterested.text = String(post.interestedNumber) + " interested"
        eventName.text = post.eventName
        eventPoster.text = "Posted by: " + post.posterName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        eventDate.text = "It's happening " + dateFormatter.string(from: post.eventTime) + "!"
        post.getImage(withBlock: { img in
            self.eventImage.image = img
        })
        if post.interestedUsers.contains(s.currentUser!.email) {
            interestedButton.setTitle("Interested!", for: .normal)
            interestedButton.backgroundColor = UIColor(red: 0.21, green: 0.96, blue: 0.00, alpha: 1.00) // #36f600
        }
    }
    
    // Setup Functions
    func setupImage() {
        eventImage = UIImageView(frame: rRect(rx: 86, ry: 129, rw: 203, rh: 203))
        eventImage.contentMode = .scaleAspectFit
        eventImage.clipsToBounds = true
        eventImage.image = UIImage(named: "placeholder")
        view.addSubview(eventImage)
    }
    
    func setupLabels() {
        eventName = UILabel(frame: rRect(rx: 0, ry: 66, rw: 375, rh: 48))
        eventName.textColor = UIColor.black
        eventName.text = "Name of Event"
        eventName.font = UIFont(name: "Helvetica", size: 36)
        eventName.textAlignment = .center
        eventName.adjustsFontSizeToFitWidth = true
        view.addSubview(eventName)
        
        eventInterested = UILabel(frame: rRect(rx: 215, ry: 334, rw: 110, rh: 24))
        eventInterested.textColor = UIColor.black
        eventInterested.text = "0 interested"
        eventInterested.font = UIFont(name: "HelveticaNeue-Italic", size: 18)
        eventInterested.adjustsFontSizeToFitWidth = true
        view.addSubview(eventInterested)
        
        eventPoster = UILabel(frame: rRect(rx: 29, ry: 358, rw: 300, rh: 27))
        eventPoster.textColor = UIColor.black
        eventPoster.text = "Posted by: Name"
        eventPoster.font = UIFont(name: "Helvetica", size: 22)
        eventPoster.adjustsFontSizeToFitWidth = true
        view.addSubview(eventPoster)
        
        eventDescription = UILabel(frame: rRect(rx: 29, ry: 387, rw: 299, rh: 48))
        eventDescription.textColor = UIColor.black
        eventDescription.text = "Brief description about the event that says important stuff about it haha"
        eventDescription.font = UIFont(name: "Helvetica", size: 18)
        eventDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventDescription.numberOfLines = 0
        view.addSubview(eventDescription)
        
        eventDate = UILabel(frame: rRect(rx: 149, ry: 480, rw: 210, rh: 27))
        eventDate.textColor = UIColor.black
        eventDate.text = "It's happening xx/xx/xx!"
        eventDate.font = UIFont(name: "Helvetica", size: 20)
        eventDate.adjustsFontSizeToFitWidth = true
        view.addSubview(eventDate)
    }
    
    func setupButtons() {
        interestedButton = UIButton(frame: rRect(rx: 54, ry: 559, rw: 267, rh: 70))
        interestedButton.backgroundColor = UIColor(red: 0.96, green: 0.76, blue: 0.10, alpha: 1.0) // #ffe797
        interestedButton.setTitle("Interested?", for: .normal)
        interestedButton.addTarget(self, action: #selector(interestedButtonPressed), for: .touchUpInside)
        interestedButton.layer.cornerRadius = 33
        view.addSubview(interestedButton)
    }
    
    // Selectors
    @objc
    func interestedButtonPressed() {
        if interestedButton.currentTitle == "Interested?" {
            interestedButton.setTitle("Interested!", for: .normal)
            interestedButton.backgroundColor = UIColor(red: 0.21, green: 0.96, blue: 0.00, alpha: 1.00) // #36f600
            post.interestedNumber += 1
            post.interestedUsers.append(s.currentUser!.email)
        } else {
            interestedButton.setTitle("Interested?", for: .normal)
            interestedButton.backgroundColor = UIColor(red: 0.96, green: 0.76, blue: 0.10, alpha: 1.0) // #ffe797
            post.interestedNumber -= 1
            if let index = post.interestedUsers.index(of:s.currentUser!.email) {
                post.interestedUsers.remove(at: index)
            }
        }
        eventInterested.text = String(post.interestedNumber) + " interested"
        DB.updateInterested(post: post, email: s.currentUser!.email, interested: interestedButton.currentTitle == "Interested!")
    }
}

