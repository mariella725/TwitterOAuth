//
//  twitterClient.swift
//  Twitter
//
//  Created by Mariella Sypa on 2/10/16.
//  Copyright © 2016 Mariella Sypa. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "mbxtfEA8hlMx6h04IIyf8uT0T"
let twitterConsumerSecret = "E2qxx1Bdx0ejIg2miIr05GlxprO4vti7xNcNLohMrwU2zNUdo7"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class twitterClient: BDBOAuth1SessionManager {
    

    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: twitterClient {
        struct Static {
            static let instance = twitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        // home timeline endpoint
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            // print("home timeline: \(response)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
        }, failure: {(operation: NSURLSessionDataTask?, error: NSError!) -> Void in
            print("error getting home timeline")
            completion(tweets: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        
        // fetch request token (took out of view controller)
        twitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        twitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterMariella://oauth"), scope: nil, success: {
            (requestToken: BDBOAuth1Credential!) -> Void in
            print("got the request token")
            
            // let twitter know we're authorized to send user here
            let authURL = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) {
                (error: NSError!) -> Void in
                print("failed to get request token: \(error)")
                // if failure, call login completion and give it a nil user and an error
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    // handle the open url
    func openURL(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: {(accessToken: BDBOAuth1Credential!) -> Void in
            print("got the access token!")
            
           
            twitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            twitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: {(operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                // print("user: \(response)")
                
                // logging in
                let user = User(dictionary: response as! NSDictionary)

                // persists user as current user
                User.currentUser = user
                
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
            }, failure: {(operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })

            
        }) {
           (error: NSError!) -> Void in
           print("failed to receive access token")
        }
    }
    
}
