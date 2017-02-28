//
//  LoginViewController.swift
//  TwitterClientDemo
//
//  Created by Pratik Koirala on 2/26/17.
//  Copyright © 2017 Pratik Koirala. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogin(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "kyt1AJtv6PgTHh7MBYyRSGOes", consumerSecret: "hFfVCL6nMVonX2oWNwu3vGOuSc7betzCqGnfhMm5SCjkvaR7K2")
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string:"twitterDemo456://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print ("Got token")
            let myToken = requestToken!.token as String!
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(myToken!)")!
            UIApplication.shared.openURL(url as URL)
        }, failure: { (error:Error?)-> Void in
            print ("Error getting token: \(error!.localizedDescription)")
        })
  
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
