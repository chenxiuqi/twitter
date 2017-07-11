//
//  FollowersViewController.swift
//  twitter_alamofire_demo
//
//  Created by Xiu Chen on 7/10/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var user: User? = nil
    var followers: [[String: Any]] = [[:]]
    var followersImageURLString: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        if user == nil {
            user = User.current
        }
        APIManager.shared.getFollowersList(with: (user?.screenName)!) { (tweets, error) in
            if let tweets = tweets {
                self.followers = tweets["users"] as! [[String:Any]]
                for user in self.followers {
                    self.followersImageURLString.append(user["profile_image_url_https"] ?? "")
                }
                
                self.collectionView.reloadData()
            } else if let error = error {
                print("Error getting current user's following list: " + error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followersImageURLString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! FollowersCollectionViewCell
        let userImageURLString = (self.followersImageURLString[indexPath.item] as! String).replacingOccurrences(of: "_normal", with: "")
        let userImageURL = URL(string: userImageURLString)
        cell.userImageView.af_setImage(withURL: userImageURL!)
        return cell
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
