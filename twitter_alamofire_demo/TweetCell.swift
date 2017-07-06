//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            userNameLabel.text = "@" + tweet.user.screenName!
            screenNameLabel.text = tweet.user.name
            timeStampLabel.text = tweet.createdAtString
            
            refreshData()
            
            self.userImage.layer.cornerRadius = (self.userImage.frame.size.width / 2)
            self.userImage.layer.masksToBounds = true
            userImage.af_setImage(withURL: tweet.user.profileImageURL!)
        }
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        
        if tweet.favorited == false {
            tweet.favorited = true
            tweet.favoriteCount = tweet.favoriteCount! + 1
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            refreshData()
        } else {
            tweet.favorited = false
            tweet.favoriteCount = tweet.favoriteCount! - 1
            favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            refreshData()
        }
    }
    
    // refreshData method to repopulate the cell information
    func refreshData() {
        // Favorite count
        if tweet.favorited == true {
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
        }
        favoriteCount.text = String(describing: tweet.favoriteCount!)
        
        // Retweet count
        if tweet.retweeted == true {
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
        }
        retweetCount.text = String(describing: tweet.retweetCount)
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            tweet.retweetCount = tweet.retweetCount + 1
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            refreshData()
        } else {
            tweet.retweeted = false
            tweet.retweetCount = tweet.retweetCount - 1
            retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
            
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
            refreshData()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
