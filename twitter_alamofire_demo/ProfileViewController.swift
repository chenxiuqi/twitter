//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Xiu Chen on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerImage: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    
    var tweets: [Tweet] = []
    var user: User? = nil
    var fromTimeline: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        if !fromTimeline {
            user = User.current
        }
        
        APIManager.shared.getUserTimeLine(with: (user?.screenName)!) { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting current user timeline: " + error.localizedDescription)
            }
        }
        
        // Setting the Profile Image
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.size.width / 2)
        self.profileImage.layer.masksToBounds = true
        profileImage.af_setImage(withURL: (user?.biggerProfileImageURL!)!)
        
        
        // Setting the Banner Image
        bannerImage.af_setImage(withURL: (user?.bannerImageURL!)!)
        
        // Setting the Bio Section
        screenNameLabel.text = user?.name
        userNameLabel.text = "@" + (user?.screenName)!
        bioLabel.text = user?.bio
        
        let followingCount = user?.followingCount!
        let followersCount = user?.followersCount!
        
        followingLabel.text = String(describing: followingCount!)
        followersLabel.text = String(describing: followersCount!)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    @IBAction func onCancel(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let detailViewController = segue.destination as! DetailViewController
            let tweet = tweets[indexPath.row]
            detailViewController.tweet = tweet
        }
        
    }
}
