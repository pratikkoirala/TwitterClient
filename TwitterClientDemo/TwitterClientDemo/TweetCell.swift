//
//  TweetCell.swift
//  TwitterClientDemo
//
//  Created by Pratik Koirala on 2/27/17.
//  Copyright © 2017 Pratik Koirala. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var tweetTitle: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!

    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetDetail: UILabel!
    
    var tweet: Tweet!{
        didSet{
            
            tweetDetail.text = tweet.text as? String
            tweetTitle.text = tweet.userName as! String
            
            let imageURL = URL(string: tweet.imageUrl as! String)
            profileImage.setImageWith(imageURL! as URL)
            timestampLabel.text = TwitterAPI.changeTimeStampFormatToString(timestamp: tweet.timestamp as! Date)
            
            retweetLabel.text = tweet.retweetCountString
            favLabel.text = tweet.favCountString
            
            if (!tweet.reTweet!) {
                retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            } else {
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }
            if (!tweet.favTweet!) {
                favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            } else {
                favButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            }
            
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        
        tweet.reTweet! = !tweet.reTweet!
        if (self.tweet.reTweet!) {
            
            self.tweet.retweetCount += 1
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        } else {
            self.tweet.retweetCount -= 1
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        
        self.tweet.retweetCountString = "\(self.tweet.retweetCount)"
        retweetLabel.text = self.tweet.retweetCountString
    }

    @IBAction func onFavPressed(_ sender: Any) {
        self.tweet.favTweet = !self.tweet.favTweet!
        
        if (self.tweet.favTweet!) {
            self.tweet.favCount += 1
            favButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        } else {
            self.tweet.favCount -= 1
            favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
        
        self.tweet.favCountString = "\(self.tweet.favCount)"
        favLabel.text = self.tweet.favCountString
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
