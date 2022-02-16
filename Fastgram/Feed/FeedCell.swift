//
//  FeedCell.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/16.
//

import Foundation
import UIKit

class FeedCell: UITableViewCell {
    var feed: Feed! {
        didSet {
            guard let feed = feed, feed != oldValue else { return }
            
            if let url = URL(string: feed.user.profileImageURl) {
                userPhotoView.setImage(url: url)
            }
            
            collectionView.contentOffset = .zero
            collectionView.reloadData()
            pageControl.currentPage = 0
            
            contentLabel.text = feed.content
            userNameLabel.text = feed.user.name
            
            pageControl.numberOfPages = feed.medias.count
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userPhotoView.makeRound()
    }
    
    @IBOutlet weak private var userPhotoView: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var contentLabel: UILabel!
    @IBOutlet weak private var likeView: UIView!
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var likeCountLabel: UILabel!
    @IBOutlet weak private var container: UIView!
    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var collectionView: UICollectionView!
}

extension FeedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        feed.medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedImageCell", for: indexPath) as! FeedImageCell
        
        cell.url = URL(string: feed.medias[indexPath.item].url)!
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}
