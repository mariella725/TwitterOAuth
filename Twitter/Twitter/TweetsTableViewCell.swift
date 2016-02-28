//
//  TweetsTableViewCell.swift
//  Twitter
//
//  Created by Mariella Sypa on 2/21/16.
//  Copyright © 2016 Mariella Sypa. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetContentText: UILabel!
    @IBOutlet weak var createdTime: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            print("prof pic:")
            print(tweet.authorProfilePicURL);
            profileImage.setImageWithURL(tweet.authorProfilePicURL!)
            profileImage.layer.cornerRadius = 4
            userName.text = tweet.author as? String
            userHandle.text = "@" + (tweet.screenname as! String)
            createdTime.text = String(tweet.timestamp!)
            
            tweetContentText.text = tweet.text as? String
            
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
