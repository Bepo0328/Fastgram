//
//  UIImageView+Extension.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/16.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    func setImage(url: URL) {
        self.af.setImage(withURL: url, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false, completion: nil)
    }
}
