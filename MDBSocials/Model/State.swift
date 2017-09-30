//
//  State.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/27/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

class State {
    var currentUser: User?
    var posts: [Post]
    
    init() {
        posts = []
    }
    
    func sortPosts() {
        posts.sort { (obj1, obj2) -> Bool in
            return obj1.dateCreated > obj2.dateCreated
        }
    }
}
