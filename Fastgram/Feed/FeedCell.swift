//
//  FeedCell.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/16.
//

import Foundation
import UIKit
import AVFoundation

protocol FeedCellDelegate: AnyObject {
    func feedCell(_ cell: FeedCell, toggleLike feed: Feed)
    func feedCell(_ cell: FeedCell, selectUser user: User)
    func feedCellShouldExpand(_ cell: FeedCell)
}

class FeedCell: UITableViewCell, MoviePlayable {
    @IBOutlet weak private var userPhotoView: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var contentLabel: UILabel!
    @IBOutlet weak private var likeView: UIView!
    @IBOutlet weak private var likeButton: UIButton!
    @IBOutlet weak private var likeCountLabel: UILabel!
    @IBOutlet weak private var container: UIView!
    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    weak var delegate: FeedCellDelegate?
    var feed: Feed! {
        didSet {
            guard let feed = feed, feed != oldValue else { return }
            
            if let url = URL(string: feed.user.profileImageURl) {
                userPhotoView.setImage(url: url)
            }
            
            collectionView.contentOffset = .zero
            collectionView.reloadData()
            pageControl.currentPage = 0
            
            userNameLabel.text = feed.user.name
            
            pageControl.numberOfPages = feed.medias.count
            
            updateLike(feed)
            
            likeView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            likeView.alpha = 0
            
            let content = "\(feed.user.name) \(feed.content)"
            let more = "... 더보기"
            let text = NSMutableAttributedString(string: content)
            
            text.addAttribute(.font, value: UIFont.systemFont(ofSize: 13), range: NSRange(location: 0, length: content.count))
            text.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .bold), range: NSRange(location: 0, length: feed.user.name.count))
            
            if content.hasSuffix(more) {
                text.addAttribute(.foregroundColor, value: UIColor.lightGray, range: NSRange(location: content.count - more.count, length: more.count))
            }
            
            contentLabel.attributedText = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userPhotoView.makeRound()
        self.addLikeGesture()
        self.contentLabel.isUserInteractionEnabled = true
        
        let textTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectText))
        self.contentLabel.addGestureRecognizer(textTapGestureRecognizer)
    }
    
    func addLikeGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateLike))
        tapGestureRecognizer.numberOfTapsRequired = 2
        self.container.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func selectText() {
        delegate?.feedCellShouldExpand(self)
    }
    
    @objc func animateLike() {
        if feed.liked == false {
            delegate?.feedCell(self, toggleLike: feed)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.likeView.alpha = 1
            self.likeView.transform = .identity
            self.likeButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0.5, options: .curveEaseInOut, animations: {
                self.likeView.alpha = 0
                self.likeView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.likeButton.transform = .identity
            }, completion: nil)
        })
    }
    
    @IBAction func selectUser() {
        delegate?.feedCell(self, selectUser: feed.user)
    }
    
    @IBAction func toggleLike() {
        delegate?.feedCell(self, toggleLike: feed)
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

extension FeedCell {
    func resume() {
        self.collectionView.visibleCells.compactMap({ $0 as? MoviePlayable }).forEach({
            $0.pause()
        })
    }
    
    func pause() {
        self.collectionView.visibleCells.compactMap({ $0 as? MoviePlayable }).forEach({
            $0.resume()
        })
    }
    
    func isPlayable(with superView: UIView) -> Bool {
        let interaction = superView.bounds.intersection(self.frame)
        return interaction.height > superView.frame.height * 0.5
    }
}

extension FeedCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cells = collectionView.visibleCells.compactMap({ $0 as? MoviePlayable })
        
        for cell in cells {
            if cell.isPlayable(with: collectionView) {
                cell.resume()
            } else {
                cell.pause()
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
