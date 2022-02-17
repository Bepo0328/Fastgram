//
//  MediaPlayable.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/17.
//

import Foundation
import UIKit

protocol MoviePlayable: UIView {
    func resume()
    func pause()
    
    func isPlayable(with superView: UIView) -> Bool
}
