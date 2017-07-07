//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Xiu Chen on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import RSKPlaceholderTextView

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UIPageViewControllerDelegate {
    weak var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var composeView: RSKPlaceholderTextView!
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBAction func onTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: composeView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
    @IBAction func onCancel(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userImage.layer.cornerRadius = (self.userImage.frame.size.width / 2)
        self.userImage.layer.masksToBounds = true
        userImage.af_setImage(withURL: (User.current?.biggerProfileImageURL!)!)
        
        
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
