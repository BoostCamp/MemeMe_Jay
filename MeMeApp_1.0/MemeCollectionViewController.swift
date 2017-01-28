//
//  MemeCollectionViewController.swift
//  MeMeApp_1.0
//
//  Created by 한정 on 2017. 1. 24..
//  Copyright © 2017년 한정. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    // MARK: properties
    var memes:[Meme]!
    var memeCount = 0
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // Mark: Collection view
    
    // meme 갯수 리턴. 여기서는 memeCount로 따로 관리합니다.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeCount
    }
    
    // Cell의 이미지 뷰에 미미 이미지를 넣어줍니다.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.CellImageView.image = meme.memedImage
        return cell
    }
    
    // 선택했을때 상세보기 뷰로 넘어가게 됩니다.
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(detailController, animated: false)
    }
    
    // 뷰가 나타날 때 모델에 저장된 meme의 갯수와 현재 가지고 있는 memeCount가 다를 때 리로드 하게 됩니다. 리로드 할 때 memeCount를 갱신합니다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        if(appDelegate.memes.count != memeCount) {
            memes = appDelegate.memes
            memeCount = memes.count
        }
        collectionView?.reloadData()
    }
    
    // MARK: viewDidLoad
    // layout을 정리 합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 1.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

    

}
