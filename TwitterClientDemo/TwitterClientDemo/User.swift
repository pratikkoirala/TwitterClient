//
//  User.swift
//  TwitterClientDemo
//
//  Created by Pratik Koirala on 2/27/17.
//  Copyright © 2017 Pratik Koirala. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let  userDidLogoutNotification = "userDidLogout"
    
    //Properties of User object
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagLine: NSString?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? NSString
        screenname = dictionary["screen_name"] as? NSString
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        
        }
        tagLine = dictionary["description"] as? NSString
    }
    static var _currentUser: User?
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                
                if let userData = userData{
                    do{
                        let dictionary = try JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
                    }
                    catch let error as NSError{
                        print("Error:\(error.localizedDescription)")
                    }
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            }else{
                defaults.set(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }

}
