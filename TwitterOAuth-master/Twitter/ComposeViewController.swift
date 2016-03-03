//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Mariella Sypa on 2/26/16.
//  Copyright © 2016 Mariella Sypa. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var tweet: Tweet?
    
    @IBOutlet weak var composeTextBox: UITextView!


    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if tweet != nil {
            self.composeTextBox.text = "@" + String(tweet!.author!) + " "
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func replyButton(sender: AnyObject) {
        TwitterClient.sharedInstance.compose(self.composeTextBox.text, success: { (Tweet) -> () in
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
        self.navigationController!.popViewControllerAnimated(true)
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
