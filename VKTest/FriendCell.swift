//
//  FriendCell.swift
//  VKTest
//
//  Created by Daniil Smirnov on 24.10.16.
//  Copyright © 2016 Daniil Smirnov. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var mobile: UIImageView!
    @IBOutlet var onlineView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoView.image = UIImage(named: "camera_50")
        mobile.image = UIImage(named: "mobile")!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        mobile.tintColor = UIColor.green
        layoutIfNeeded()
        photoView.layer.masksToBounds = true
        photoView.layer.cornerRadius = photoView.frame.width/2
        onlineView.layer.masksToBounds = true
        onlineView.layer.cornerRadius = onlineView.frame.width/2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
