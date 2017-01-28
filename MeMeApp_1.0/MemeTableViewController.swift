//
//  MemeTableViewController.swift
//  MeMeApp_1.0
//
//  Created by 한정 on 2017. 1. 24..
//  Copyright © 2017년 한정. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    // MARK: properties
    var memes: [Meme]!
    var memeCount = 0
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeCount
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.TableImageView.image = meme.memedImage
        cell.LblTop.text = "\(meme.topText!)"
        cell.LblBottom.text = "\(meme.bottomText!)"
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(detailController, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            memes.remove(at: indexPath.row)
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.remove(at: indexPath.row)
            memeCount -= 1
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // view가 나타날 때 memeCount와 모델 내 카운트가 다를 때 리로드
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
        setEditing(false, animated: true)
    }
    

}
