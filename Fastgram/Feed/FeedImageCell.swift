//
//  FeedImageCell.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/16.
//

import Foundation
import UIKit

class FeedImageCell: UICollectionViewCell {
    var url: URL! {
        didSet {
            imageView.setImage(url: url)
        }
    }
    @IBOutlet weak private var imageView: UIImageView!
}
