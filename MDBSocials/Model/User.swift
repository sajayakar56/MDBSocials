//
//  User.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/27/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

class User {
    var name: String
    var email: String
    var imageUrl: String
    var uid: String
    
    // maybe make it take in uid and get the other info? 
    init(id: String, userDict: [String:Any]!) {
        self.name = userDict["name"] as! String
        self.email = userDict["email"] as! String
        imageUrl = userDict["imageUrl"] as! String
        self.uid = id
    }
    
    init(name: String, username: String,
                     email: String, imageUrl: String,
                     uid: String) {
        self.name = name
        self.email = email
        self.imageUrl = imageUrl
        self.uid = uid
    }
    
}
