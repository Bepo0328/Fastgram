//
//  Feed.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/16.
//

import Foundation

struct Feed {
    let id: TimeInterval
    let user: User
    let medias: [FeedMeida]
    
    var content: String
    var liked: Bool
    var likeCount: Int
}

extension Feed: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Feed {
    static func createRandom() -> Feed {
        let id = Date().timeIntervalSince1970
        let user = User.createRandom()
        let count = (1...10).randomElement()!
        let medias = (1...count).map { _ in FeedMeida.createRandom() }
        let content = [
            "You've gotta dance like there's nobody watching, Love like you'll never be hurt, Sing like there's nobody listening, And live like it's heaven on earth",
            "Be yourself; everyone else is already taken.",
            "Two things are infinite: the universe and human stupidity; and I'm not sure the universe.",
            "So many books, so little time",
            "A room without books is like a body without a soul."
        ].randomElement()!
        let liked = (0...1).randomElement() == 0 ? true : false
        let likeCount = (1...100).randomElement()!
    
        return Feed(id: id, user: user, medias: medias, content: content, liked: liked, likeCount: likeCount)
    }
}
