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
        let client = TwitterAPI.sharedInstance
        client?.login(success: { 
            print("Logged in")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: { (error: NSError) in
            print("Error: \(error.localizedDescription)")
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
