//
//  Post.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/27/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import Foundation
import UIKit
import Haneke

class Post {
    var posterName: String
    var eventName: String
    var imageUrl: String
    var description: String
    var interestedNumber: Int

    init(postDict: [String:Any]) {
        self.interestedNumber = postDict["interestedNumber"] as! Int
        self.imageUrl = postDict["imageUrl"] as! String
        self.eventName = postDict["name"] as! String
        self.description = postDict["description"] as! String
        self.posterName = postDict["poster"] as! String
    }
    
    init(user: String, name: String, imageUrl: String, interestedNumber: Int) {
        self.interestedNumber = interestedNumber
        self.imageUrl = imageUrl
        eventName = name
        posterName = user
        description = ""
    }
    
    func getImage(withBlock: @escaping (UIImage) -> Void) {
        var url: URL?
        url = URL(string: imageUrl)
        let cache = Shared.imageCache
        if let u = url {
            cache.fetch(URL: u).onSuccess({ img in
                withBlock(img)})
        }
    }
}
