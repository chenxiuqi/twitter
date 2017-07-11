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
    @IBOutlet weak var mediaImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet {
            tweetLabel.text = tweet.text
            screeNameLabel.text = tweet.user.name
            usernameLabel.text = "@" + tweet.user.screenName!
            timestampLabel.text = tweet.createdAtString
            
            self.userImage.layer.cornerRadius = (self.userImage.frame.size.width / 2)
            self.userImage.layer.masksToBounds = true
            userImage.af_setImage(withURL: tweet.user.biggerProfileImageURL!)
            
            if tweet.mediaURL != nil {
                mediaImage.layer.cornerRadius = 8.0
                mediaImage.clipsToBounds = true
                mediaImage.af_setImage(withURL: tweet.mediaURL!)
                print("here")
            }
            
            
            

        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
