//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    private static var _current: User?
    var name: String?
    var screenName: String?
    var dictionary: [String: Any]?
    var bio: String?
    var followersCount: Int?
    var followingCount: Int?
    var profileImageURL: URL? // Contains URL for profile picture
    var bannerImageURL: URL? // Contains URL for user's banner/header picture
    var biggerProfileImageURL: URL?

    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        bio = dictionary["description"] as? String
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        
        // casting the profile image as URL
        let profileImageURLString = dictionary["profile_image_url_https"] as? String ?? ""
        profileImageURL = URL(string: profileImageURLString)
        
        // casting the profile image as URL for a bigger size
        let biggerProfileImageURLString = profileImageURLString.replacingOccurrences(of: "_normal", with: "")
        biggerProfileImageURL = URL(string: biggerProfileImageURLString)
        // let biggerProfileImageURLString = profileImageURLString.stringByReplacingOccurrencesOfString("normal" withString: "bigger")
        
        // casting the banner image as URL
        let bannerImageURLString = dictionary["profile_banner_url"] as? String ?? ""
        bannerImageURL = URL(string: bannerImageURLString)
    }
}
