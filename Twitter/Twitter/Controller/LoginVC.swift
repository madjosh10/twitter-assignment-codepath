//
//  LoginVC.swift
//  Twitter
//
//  Created by Joshua Madrigal on 2/12/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let URL = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: URL, success: {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            UserDefaults.standard.set(true, forKey: "userIsLoggedIn")
            
        }, failure: { (Error) in
            print("Could not log in!")
        })
    }
    

} // end LoginVC
