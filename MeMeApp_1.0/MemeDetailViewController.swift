//
//  MemeDetailViewController.swift
//  MeMeApp_1.0
//
//  Created by 한정 on 2017. 1. 25..
//  Copyright © 2017년 한정. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var MemeImageView: UIImageView!
    var meme:Meme!
    
    
    @IBAction func TouchShareButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MemeImageView.image = meme.memedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
