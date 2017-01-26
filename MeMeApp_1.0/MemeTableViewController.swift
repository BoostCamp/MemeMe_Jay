//
//  MemeTableViewController.swift
//  MeMeApp_1.0
//
//  Created by 한정 on 2017. 1. 24..
//  Copyright © 2017년 한정. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    
    var memes: [Meme]!
    var memeCount = 0
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        if(appDelegate.memes.count != memeCount) {
            memes = appDelegate.memes
            memeCount = memes.count
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        */
    }

    /*
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:

            default:
                break
            }
        }
    }
    */
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.TableImageView.image = meme.memedImage
        cell.LblTop.text = "Top: \(meme.topText!)"
        cell.LblBottom.text = "Bottom: \(meme.bottomText!)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    
}
