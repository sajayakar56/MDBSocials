//
//  FeedViewController.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/24/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UINavigationControllerDelegate {
    var s: State!
    var auth = Auth.auth()
    // Collection view for posts
    var collectionView: UICollectionView!
    var selectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        s = State()
        
        // add a post for now manually
        
        getCurrentUser {
            self.getPosts() {
                self.setupNavBar()
                self.setupButtons()
                self.setupCollectionView()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            if let post = selectedPost {
                detailVC.post = post
            }
        }
    }
    
    func getCurrentUser(withBlock: @escaping () -> ()) {
        let ref = Database.database().reference()
        ref.child("Users").child((self.auth.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = User(id: snapshot.key, userDict: snapshot.value as! [String: Any]?)
            self.s.currentUser = user
            withBlock()
        })
    }
    
    // can update this idea to have a listener that updates
    func getPosts(withBlock: @escaping () -> ()) {
        let ref = Database.database().reference()
        ref.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            // need to create the post values and add them to state
            let posts = value?.allValues
            for post in posts! {
                let p = Post(postDict: post as! [String : Any])
                self.s.posts.append(p)
                self.collectionView.reloadData()
            }
        })
        withBlock()
    }
    
    // Setup Functions
    func setupNavBar() {
        navigationItem.title = "Feed"
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logoutButtonPressed))
        let postButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(postButtonPressed))
        
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItem = postButton
    }
    
    func setupButtons() {
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: rRect(rx: 7, ry: 76, rw: 359, rh: 591), collectionViewLayout: layout)
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.lightGray
        view.addSubview(collectionView)
    }
    
    // Selectors
    @objc
    func logoutButtonPressed() {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch  {
            warning(message: "Problem signing out")
        }
    }
    
    @objc
    func postButtonPressed() {
        performSegue(withIdentifier: "feedToNew", sender: self)
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // figure out what this does
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return s.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! PostCollectionViewCell
        
        cell.awakeFromNib()
        
        // add image
        
        // do other stuff
        let post = s.posts[indexPath.row]
        cell.postName.text = post.eventName
        cell.poster.text = post.posterName
        post.getImage(withBlock: { img in
            cell.postImage.image = img
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // get the selected cell
        selectedPost = s.posts[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.95 * view.frame.width, height: 0.282 * view.frame.height)
    }        
}
