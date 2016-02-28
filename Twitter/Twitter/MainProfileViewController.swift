//
//  MainProfileViewController.swift
//  Twitter
//
//  Created by Mariella Sypa on 2/27/16.
//  Copyright © 2016 Mariella Sypa. All rights reserved.
//

import UIKit

class MainProfileViewController: UIViewController {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var profileBackgroundImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user: User!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.currentAccount({ (user: User) -> () in
            self.user = user
            self.userNameLabel.text = user.name as? String
            self.screennameLabel.text = user.screenname as? String
            self.tweetsCountLabel.text = String(user.tweetCount)
            self.followingCountLabel.text = String(user.followingCount)
            self.followersCountLabel.text = String(user.followersCount)
            
            self.profilePicImageView.setImageWithURL(user.profileUrl!)
            self.profilePicImageView.layer.cornerRadius = 4
            self.profileBackgroundImageView.setImageWithURL(user.profileBackgroundUrl!)
            self.profileBackgroundImageView.layer.cornerRadius = 4
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
