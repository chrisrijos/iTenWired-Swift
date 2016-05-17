//
//  SocialMediaCell.swift
//  Conference App
//
//  Created by Felipe on 5/17/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

import UIKit

class SocialMediaCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!

    
    func setName(name:String){
        self.nameLabel.text = name
    }
    
    func setlogo(logo:String){
        let image = UIImage(named: logo)
        self.logo.image = image
    }
}