//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/24/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import UIKit

class NewSocialViewController: UIViewController {
    var s: State!
    var postImage: UIImageView!
    var datePicker: UIDatePicker!
    var postName: UITextField!
    var postDescription: UITextView!
    var postButton: UIButton!
    var imageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupImage()
        setupDate()
        setupText()
        setupButtons()
    }
    
    // Setup Functions
    func setupImage() {
        postImage = UIImageView(frame: rRect(rx: 90, ry: 178, rw: 195, rh: 195))
        postImage.image = UIImage(named: "placeholder")
        postImage.contentMode = .scaleAspectFit
        postImage.clipsToBounds = true
        view.addSubview(postImage)
    }

    func setupDate() {
        datePicker = UIDatePicker(frame: rRect(rx: 63, ry: 390, rw: 250, rh: 156))
        datePicker.datePickerMode = .dateAndTime
        datePicker.date = Date()
        view.addSubview(datePicker)
    }
    
    func setupText() {
        postName = UITextField(frame: rRect(rx: 26, ry: 80, rw: 349, rh: 32))
        postName.placeholder = "What is it called?"
        postName.font = UIFont(name: "Helvetica", size: 24)
        postName.textColor = UIColor.black
        postName.adjustsFontSizeToFitWidth = true
        view.addSubview(postName)
        
        postDescription = UITextView(frame: rRect(rx: 31, ry: 112, rw: 349, rh: 54))
        postDescription.text = "Tell me about it!  You can only write up to two lines."
        postDescription.font = UIFont(name: "Helvetica", size: 20)
        postDescription.delegate = self
        postDescription.textColor = UIColor.lightGray
        postDescription.textContainer.maximumNumberOfLines = 2
        postDescription.textContainer.lineBreakMode = NSLineBreakMode.byClipping
        view.addSubview(postDescription)
    }
    
    func setupButtons() {
        postButton = UIButton(frame: rRect(rx: 225, ry: 589, rw: 120, rh: 51))
        postButton.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
        postButton.backgroundColor = UIColor(red: 0.31, green: 1.00, blue: 0.88, alpha: 1.0)
        postButton.setTitle("POST", for: .normal)
        postButton.setTitleColor(UIColor.white, for: .normal)
        postButton.layer.cornerRadius = 26
        view.addSubview(postButton)
        
        imageButton = UIButton(frame: rRect(rx: 42, ry: 590, rw: 156, rh: 51))
        imageButton.addTarget(self, action: #selector(loadImageButtonTapped), for: .touchUpInside)
        imageButton.backgroundColor = UIColor(red: 1.00, green: 0.31, blue: 0.31, alpha: 1.0)
        imageButton.setTitleColor(UIColor.white, for: .normal)
        imageButton.setTitle("Choose Image", for: .normal)
        imageButton.layer.cornerRadius = 26
        view.addSubview(imageButton)
    }
    
    // Selectors
    @objc
    func postButtonPressed() {
        // add check for if the fields are complete
        let emptyStringList: [String] = ["nil"]
        DB.storeImage(img: postImage.image!) { url in
            print(url)
            let post: Social = Social(postDict: ["interestedNumber": 0,
                              "imageUrl": url,
                              "name": self.postName.text,
                              "description": self.postDescription.text,
                              "poster": self.s.currentUser!.name,
                              "date": self.datePicker.date.description,
                              "dateCreated": Date().description,
                              "interestedUsers": emptyStringList])
            DB.createPost(post: post, date: Date())
            self.navigationController!.popViewController(animated: true)
        }
    }
    
    @objc
    func loadImageButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension NewSocialViewController: UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Removes the placeholder text as well as changes the color
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    // Sets the text back to placeholder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray
            textView.text = "Tell me about it!  You can only write up to two lines."
        }
    }
    
    // Called to not allow more than 2 lines of input
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let existingLines = textView.text.components(separatedBy: CharacterSet.newlines)
        let newLines = text.components(separatedBy: CharacterSet.newlines)
        let linesAfterChange = existingLines.count + newLines.count - 1
        
        return linesAfterChange <= textView.textContainer.maximumNumberOfLines
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.postImage.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
