//
//  UserViewController.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/18.
//

import Foundation
import UIKit

class UserProfileCell: UICollectionReusableView {
    @IBOutlet weak private var photoView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    
    var user: User! {
        didSet {
            if let url = URL(string: user.profileImageURl) {
                photoView.setImage(url: url)
            } else {
                photoView.image = nil
            }
            nameLabel.text = user.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoView.makeRound()
    }
}

class UserFeedCell: UICollectionViewCell {
    @IBOutlet weak private var photoView: UIImageView!
    
    var profileImage: String? {
        didSet {
            if let profileImage = profileImage, let url = URL(string: profileImage) {
                self.photoView.setImage(url: url)
            } else {
                self.photoView.image = nil
            }
        }
    }
}

class UserViewController: UIViewController {
    var user: User?
    var meidas: [FeedMeida] = {
        FeedMeida.allPhotos().shuffled()
    }()
}

extension UserViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        meidas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserFeedCell", for: indexPath) as! UserFeedCell
        
        cell.profileImage = meidas[indexPath.row].url
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UserProfileCell", for: indexPath) as! UserProfileCell
        
        view.user = self.user
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 2) / 3
        return CGSize(width: size, height: size)
    }
}
