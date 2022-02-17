//
//  FeedCell.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/16.
//

import Foundation
import UIKit
import AVFoundation

class FeedCell: UITableViewCell {
    @IBOutlet weak private var userPhotoView: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var contentLabel: UILabel!
    @IBOutlet weak private var likeView: UIView!
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var likeCountLabel: UILabel!
    @IBOutlet weak private var container: UIView!
    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var collectionView: UICollectionView!
    
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
            
            updateLike(feed)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userPhotoView.makeRound()
    }
    
    func updateLike(_ feed: Feed) {
        likeCountLabel.text = "좋아요 \(feed.likeCount)개"
        likeButton.isSelected = feed.liked
        likeButton.tintColor = feed.liked ? .systemPink : .black
    }
    
}

extension FeedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        feed.medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let media = feed.medias[indexPath.item]
        
        switch media.type {
        case .photo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedImageCell", for: indexPath) as! FeedImageCell
            cell.url = URL(string: feed.medias[indexPath.item].url)!
            return cell
        case .movie:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedMovieCell", for: indexPath) as! FeedMovieCell
            let url = URL(string: media.url)!
            let item = AVPlayerItem(url: url)
            
            cell.player.replaceCurrentItem(with: item)
            cell.resume()
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension FeedCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cells = collectionView.visibleCells.compactMap({ $0 as? MoviePlayable })
        
        for cell in cells {
            let intersection = collectionView.bounds.intersection(cell.frame)
            if intersection.width > collectionView.frame.width * 0.5 {
                cell.resume()
            } else {
                cell.pasue()
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let x = scrollView.contentOffset.x
        let index = x / width
        
        pageControl.currentPage = Int(index)
    }
}
