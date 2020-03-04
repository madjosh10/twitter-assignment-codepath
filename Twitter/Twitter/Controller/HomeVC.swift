//
//  HomeVC.swift
//  Twitter
//
//  Created by Joshua Madrigal on 2/17/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeVC: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfTweets = 20
        loadTweets()
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweets()
    }
    
    @objc func loadTweets() {
        numberOfTweets = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let parameter = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: parameter as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not load tweets..")
        })
    } // end loadTweets

    @objc func loadMoreTweets() {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets += 20
        let parameter = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: parameter as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Could not load tweets..")
        })
        
    } // end loadMoreTweets
   
    
    @IBAction func logOutPressed(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userIsLoggedIn")
    } // end logOutPressed
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        let user  = tweetArray[indexPath.row]["user"] as! NSDictionary
        let tweet = tweetArray[indexPath.row]["text"] as! String
        
        cell.userName.text = user["name"] as? String
        cell.tweetContent.text = tweet
        cell.tweetedAgo.text = getRelativeTime(timeString: ((tweetArray[indexPath.row]["created_at"] as? String)!))
        
        let imageURL = URL(string: (user["profile_image_url"]as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            cell.userImage.image = UIImage(data: imageData)
        }
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        
        return cell
    }

    // MARK: - Table view data source

     override func numberOfSections(in tableView: UITableView) -> Int {
         
        return 1
        
     }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return tweetArray.count
     }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
        
    }
    
    func getRelativeTime(timeString: String) -> String {
        
        let time: Date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        time = dateFormatter.date(from: timeString)!
        
        return time.timeAgoDisplay()
        
    }

} // end HomeVC

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        if secondsAgo < minute {
            return "\(secondsAgo) sec ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) min ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hrs ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }
        return "\(secondsAgo / week) weeks ago"
        
    }
    
}
