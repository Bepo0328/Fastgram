//
//  User.swift
//  Fastgram
//
//  Created by 전윤현 on 2022/02/16.
//

import Foundation

struct User {
    let name: String
    let profileImageURl: String
}

extension User {
    static func createRandom() -> User {
        let name = ["남온조", "이청산", "최남라", "이수혁", "윤귀남", "이나연"]
        
        let profileImages = [
            "https://w.namu.la/s/5b393c03b06ecbc1671b9bfbf65652f348c98f5e63df3669f1da7ed70acada8b88d3c36040f7040867e3b07291182653fb439eefbbe7f769674630bb438924502feb04860d3f3ababb8f93f953c35153bdb7c6cecf38b2f94b0d311357f45268",
            "https://w.namu.la/s/2e06046a94246cde386ddd9eb9f0077de49ce5b9367b509569a0d55ab458a34ed4d1d940bf01a344208f221bfc0b0c45347e55b1e30c311df8e86ba0d62bf73d8db74366e0424ab210352f188401e2870685348265ffa8139afff4d05454ff01",
            "https://w.namu.la/s/ff86910fa5f0fd928732cb670e24e72d80f4a1a849ff82e6629ea879910b752d1aa63018c6f02f3de00aa8980fa1ae4c7e7c8bc55b375e871c665e9780e12333099d1d414ccd75de29020fa504371d87d97ec35f1fb3c18cc07105e238ddfa68",
            "https://w.namu.la/s/cfc9e0c4b7d404476900339b7faa6106b85e06a9a080a1eb7f481cd471e26a0b59a11b33428aacbd25601c903ac2d8dbea5e5eca59b5fd771f61698a727928b0a5e81c14a62e0c95f3f199343907719af5364a85f3bcca38fe389955a751c0a5",
            "https://w.namu.la/s/9181809dd7b7940fd2cc2dec6f6af01169509ba46c4aaa7cb102b09d396bbe5d0f54af5f533c548c32d51ba43f353384b3aa35abeb17a9535d4aee3cd1f27d235f68079c9da919c1c1561977cbccd818333b0af1301f0a0c95e394ccf94cd068",
            "https://w.namu.la/s/7d1737fae3c3eae5851dbc874dbef22ae41c7da28e2a65285b971169e758d0d1cb0b2ebe56338317e36a32e7574eb7eb029a283903d383048cd66629f5238eda70d88b8c65d55442d204b3993a0ae3f77f02e7a744166b8523d9e185d53f134f"
        ]
        
        return User(name: name.randomElement()!, profileImageURl: profileImages.randomElement()!)
    }
}
