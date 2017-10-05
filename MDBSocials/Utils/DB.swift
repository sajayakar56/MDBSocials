//
//  Database.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/29/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//
import Firebase


// Static Class to handle Firebase calls
class DB {
    class func getCurrentUser(withBlock: @escaping (User) -> ()) {
        let ref = Database.database().reference()
        ref.child("Users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = User(id: snapshot.key, userDict: snapshot.value as! [String: Any]?)
            withBlock(user)
        })
    }
    
    class func createPost(post: Social, date: Date) {
        let ref = Database.database().reference().child("Posts").child((date.description))
        let dict: [String: Any] = ["name": post.eventName,
                    "imageUrl": post.imageUrl,
                    "interestedNumber": post.interestedNumber,
                    "description": post.description,
                    "poster": post.posterName,
                    "date": post.eventTime.description,
                    "dateCreated": post.dateCreated.description,
                    "interestedUsers": post.interestedUsers]
        ref.setValue(dict)
    }
    
    class func refreshPosts(withBlock: @escaping ([Social]) -> ()) {
        let ref = Database.database().reference()
        var posts: [Social] = []
        ref.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            // need to create the post values and add them to state
            if let v = value {
                for (key, val) in v {
                    let key = key as! String
                    let val = val as! [String: Any]
                    let post = Social(postDict: val)
                    posts.append(post)
                    withBlock(posts)
                }
            }
        })
    }
    
    class func updateInterested(post: Social, email: String, interested: Bool) {
        let ref = Database.database().reference().child("Posts").child(post.dateCreated.description)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                let interestedUsers = value["interestedUsers"] as! [String]
                let interestedCount = value["interestedNumber"] as! Int
                // this code should only run if the database must be updated
                if interestedUsers.contains(email) != interested {
                    // we can do this, because it will just end up updating relevant fields
                    createPost(post: post, date: post.dateCreated)
                }
            }
        })
    }
    
    class func storeImage(img: UIImage, withBlock: @escaping (String) -> ()) {
        let storage = Storage.storage().reference().child("postpics")
        let metadata = StorageMetadata()
        let imgData = UIImageJPEGRepresentation(img, 0.9)
        var url = ""
        metadata.contentType = "image/jpeg"
        storage.putData(imgData!, metadata: metadata).observe(.success) { (snapshot) in
            url = (snapshot.metadata?.downloadURL()?.absoluteString)!
            withBlock(url)
        }
    }
}
