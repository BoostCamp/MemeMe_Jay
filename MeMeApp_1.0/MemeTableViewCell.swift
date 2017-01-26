//
//  MemeTableViewCell.swift
//  MeMeApp_1.0
//
//  Created by 한정 on 2017. 1. 25..
//  Copyright © 2017년 한정. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var TableImageView: UIImageView!
    @IBOutlet weak var LblTop: UILabel!
    @IBOutlet weak var LblBottom: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
