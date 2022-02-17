//
//  MoviePlayerView.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/17.
//

import Foundation
import UIKit
import AVKit

class MoviePlayerView: UIView {
    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}
