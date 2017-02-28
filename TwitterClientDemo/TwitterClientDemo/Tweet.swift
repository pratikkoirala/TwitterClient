//
//  Tweet.swift
//  TwitterClientDemo
//
//  Created by Pratik Koirala on 2/27/17.
//  Copyright © 2017 Pratik Koirala. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    // Properties of Tweet object
    
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var userName: NSString?
    var imageUrl: NSString?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? NSString
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as NSDate?
        }
        userName = (dictionary["user"] as? NSDictionary)?["name"] as? NSString
        imageUrl = (dictionary["user"] as? NSDictionary)?["profile_image_url_https"] as? NSString
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }

}
