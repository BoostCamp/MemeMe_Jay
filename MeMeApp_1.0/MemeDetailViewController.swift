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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func TouchBackButton(_ sender: Any) {
        tabBarController?.tabBar.isHidden = false
        let _ = navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func TouchShareButton(_ sender: Any) {
        let controller = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        
        controller.popoverPresentationController?.sourceView = view
        present(controller, animated: false, completion: nil)
        
        controller.completionWithItemsHandler = {
            (activityType, complete, returnedItems, activityError ) in
            if complete {
                print("complete")
                let _ = self.navigationController?.popViewController(animated: false)
            }
        }
    }
    
    @IBAction func TouchEditButton(_ sender: Any) {
        let EditController = storyboard?.instantiateViewController(withIdentifier: "MemeUpdateViewController") as! MemeUpdateViewController
        EditController.meme = self.meme
        navigationController?.pushViewController(EditController, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        MemeImageView.image = meme.memedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
