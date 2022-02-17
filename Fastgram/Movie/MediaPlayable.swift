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
    func pasue()
    
    func isPlayable(with superview: UIView) -> Bool
}
