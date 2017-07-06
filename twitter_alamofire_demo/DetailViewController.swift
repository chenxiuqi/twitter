//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Xiu Chen on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    var tweet: Tweet?

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var screeNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet {
            tweetLabel.text = tweet.text
            screeNameLabel.text = tweet.user.name
            usernameLabel.text = "@" + tweet.user.screenName!
            timestampLabel.text = tweet.createdAtString
            
            self.userImage.layer.cornerRadius = (self.userImage.frame.size.width / 2)
            self.userImage.layer.masksToBounds = true
            userImage.af_setImage(withURL: tweet.user.profileImageURL!)

            
            
            
            
//            tweetTextLabel.text = tweet.text
//            userNameLabel.text = "@" + tweet.user.screenName!
//            screenNameLabel.text = tweet.user.name
//            timeStampLabel.text = tweet.createdAtString
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
