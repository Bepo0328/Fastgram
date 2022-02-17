//
//  FeedMovieCell.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/17.
//

import Foundation
import UIKit
import AVKit

class FeedMovieCell: UICollectionViewCell, MoviePlayable {
    let player = AVPlayer()
    
    @IBOutlet weak private var playerView: MoviePlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.playerView.player = player
        self.playerView.playerLayer.videoGravity = .resizeAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func resume() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func isPlayable(with superView: UIView) -> Bool {
        let intersection = superView.bounds.intersection(self.frame)
        return intersection.width > superView.frame.width * 0.5
    }
}
