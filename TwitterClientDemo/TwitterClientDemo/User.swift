//
//  User.swift
//  TwitterClientDemo
//
//  Created by Pratik Koirala on 2/27/17.
//  Copyright © 2017 Pratik Koirala. All rights reserved.
//

import UIKit

class User: NSObject {
    
    //Properties of User object
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagLine: NSString?
    
    init(dictionary: NSDictionary){
        name = dictionary["name"] as? NSString
        screenname = dictionary["screen_name"] as? NSString
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        
        }
        tagLine = dictionary["description"] as? NSString
    }

}
