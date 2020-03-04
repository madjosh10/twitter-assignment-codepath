//
//  TweetCell.swift
//  Twitter
//
//  Created by Joshua Madrigal on 2/19/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    var favorited: Bool = false
    var tweetId: Int = -1
    var retweeted: Bool = false
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var tweetedAgo: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavorite(_ isFavoriated: Bool) {
        favorited = isFavoriated
        if(isFavoriated) {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func favClicked(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (erro) in
                print("unFavorite did not succeed: \(erro)")
            })
        }
        
    }
    
    @IBAction func retweetClicked(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("retweet is not successful: \(error)")
        })
        
    }

}
