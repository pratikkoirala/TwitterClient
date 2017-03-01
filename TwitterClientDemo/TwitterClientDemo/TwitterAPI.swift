//
//  TwitterAPI.swift
//  TwitterClientDemo
//
//  Created by Pratik Koirala on 2/27/17.
//  Copyright © 2017 Pratik Koirala. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterAPI: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterAPI(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "kyt1AJtv6PgTHh7MBYyRSGOes", consumerSecret: "hFfVCL6nMVonX2oWNwu3vGOuSc7betzCqGnfhMm5SCjkvaR7K2")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: @escaping ()->(), failure:@escaping (NSError)->()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterAPI.sharedInstance?.deauthorize()
        TwitterAPI.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string:"twitterDemo456://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print ("Got token")
            let myToken = requestToken!.token as String!
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(myToken!)")!
            UIApplication.shared.openURL(url as URL)
        }, failure: { (error:Error?)-> Void in
            print ("Error getting token: \(error!.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
    }
    
    func handleOpenurl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                
            }, failure: { (error: NSError) in
                self.loginFailure?(error)
            })
            self.loginSuccess?()
            
            
        }, failure: { (error: Error?) in
            print ("error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
    }
    
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: (NSError) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print  ("error:\(error.localizedDescription)")
        })

    }

    func currentAccount(success:@escaping (User) -> (), failure:@escaping (NSError) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            print("name:\(user.name)")
            print("screenname:\(user.screenname)")
            print("profile url: \(user.profileUrl)")
            print("description: \(user.tagLine)")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("Error: \(error.localizedDescription)")
            failure(error as NSError)
        })
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }

}
