//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Mariella Sypa on 2/21/16.
//  Copyright © 2016 Mariella Sypa. All rights reserved.
//

import UIKit

class tweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var tweets: [Tweet]!
    var tweet: Tweet?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count;
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetsTableViewCell
        cell.tweet = tweets![indexPath.row]
        
        cell.profileImage.userInteractionEnabled = true
        
        let tapped = UITapGestureRecognizer(target: self, action: "tappedProfileImage:")
        tapped.numberOfTapsRequired = 1
        cell.profileImage.addGestureRecognizer(tapped)
        
        
        
        return cell
    }
    
    func tappedProfileImage(gesture: UITapGestureRecognizer) {
        performSegueWithIdentifier("profilePic", sender: nil)

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
        
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
/*        if (segue.identifier == "profilePic") {
            let userTweet = tweets![1]
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.tweet = userTweet
        }
*/        
    
        if (segue.identifier == "tweetClick") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
            tweetDetailViewController.tweet = tweet
        }
    }

}
