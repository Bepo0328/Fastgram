//
//  UIView+Extension.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/16.
//

import Foundation
import UIKit

extension UIView {
    func makeRound() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
}
