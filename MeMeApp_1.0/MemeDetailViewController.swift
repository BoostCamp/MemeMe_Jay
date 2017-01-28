//
//  MemeDetailViewController.swift
//  MeMeApp_1.0
//
//  Created by 한정 on 2017. 1. 25..
//  Copyright © 2017년 한정. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    // MARK: properties
    @IBOutlet weak var MemeImageView: UIImageView!
    var meme:Meme!
    
    // MARK: Touch Back Button
    // tabbar hidden 해제, back to root view controller
    @IBAction func TouchBackButton(_ sender: Any) {
        tabBarController?.tabBar.isHidden = false
        let _ = navigationController?.popToRootViewController(animated: false)
    }
    
    // MARK: Touch Share Button
    // use ActivityViewController. 여기서는 미미 객체에 저장은 안됨. 폰에만 저장이 되게
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
    
    // MARK: Touch Edit Button
    @IBAction func TouchEditButton(_ sender: Any) {
        let EditController = storyboard?.instantiateViewController(withIdentifier: "MemeUpdateViewController") as! MemeUpdateViewController
        EditController.meme = self.meme
        navigationController?.pushViewController(EditController, animated: false)
    }
    
    // MARK: ViewDidLoad function
    // meme Image 가져오기, tabbar 숨기기
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        MemeImageView.image = meme.memedImage
    }
}
