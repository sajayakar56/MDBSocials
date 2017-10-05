//
//  PostCollectionViewCell.swift
//  MDBSocials
//
//  Created by Stephen Jayakar on 9/28/17.
//  Copyright © 2017 Stephen Jayakar. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    var postImage: UIImageView!
    var postName: UILabel!
    var interested: UILabel!
    var poster: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.white
        // I think the x and y might be wrong: rework
        postImage = UIImageView(frame: CGRect(x: 10,
                                              y: 10,
                                              width: 0.45 * contentView.frame.width,
                                              height: contentView.frame.height - 10))
        postImage.contentMode = .scaleAspectFit
        postImage.clipsToBounds = true
        postImage.image = UIImage(named: "placeholder")
        contentView.addSubview(postImage)
        
        // labels!
        postName = UILabel(frame: CGRect(x: 0.51 * contentView.frame.width,
                                         y: 0.12 * contentView.frame.height,
                                         width: 0.37 * contentView.frame.width,
                                         height: 0.14 * contentView.frame.height))
        postName.adjustsFontSizeToFitWidth = true
        postName.textColor = UIColor.black
        postName.text = ""
        postName.font = UIFont(name: "Helvetica", size: 20)
        contentView.addSubview(postName)
        
        poster = UILabel(frame: CGRect(x: 0.51 * contentView.frame.width,
                                       y: 0.25 * contentView.frame.height,
                                       width: 0.37 * contentView.frame.width,
                                       height: 0.14 * contentView.frame.height))
        poster.textColor = UIColor.black
        poster.text = ""
        poster.font = UIFont(name: "Helvetica", size: 16)
        contentView.addSubview(poster)
        
        interested = UILabel(frame: CGRect(x: 0.70 * contentView.frame.width,
                                           y: 0.89 * contentView.frame.height,
                                           width: 0.24 * contentView.frame.width,
                                           height: 0.07 * contentView.frame.height))
        interested.text = "0 interested"
        interested.font = UIFont(name: "HelveticaNeue-Italic", size: 14)
        contentView.addSubview(interested)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postName.isHidden = true
        poster.isHidden = true
        interested.isHidden = true
        postImage.isHidden = true
    }
}
