//
//  TweetVC.swift
//  Twitter
//
//  Created by Joshua Madrigal on 3/2/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetVC: UIViewController {

    @IBOutlet weak var tweetTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweetClicked(_ sender: Any) {
        if(!tweetTextField.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextField.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else {
        self.dismiss(animated: true, completion: nil)
                
        }
    }
}

