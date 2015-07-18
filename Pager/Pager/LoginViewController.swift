//
//  LoginViewController.swift
//  Pager
//
//  Created by Anuj Verma on 7/16/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit
import ParseFacebookUtils
import FBSDKCoreKit

class LoginViewController: UIViewController {

    let permissions = ["public_profile"]
    
    @IBOutlet weak var loginStatusLabel: UILabel!
    
    var currentUser: PFUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentUser = PFUser.currentUser()
        println(currentUser)
        
        
        if currentUser != nil {
            println("User is logged in")
            loginStatusLabel.text = "Welcome \(currentUser)"
            
            println("The user logged in is: \(currentUser)")
            getUserInfo()

            
        } else {
            println("No user is logged in")
            loginStatusLabel.text = "Please sign in"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func pressedLoginWithFacebook(sender: AnyObject) {
       
        PFFacebookUtils.logInWithPermissions(self.permissions, block: { (user: PFUser?, error: NSError?) -> Void in //switched ! to ? //
            if user == nil {
                println("Uh oh. The user cancelled the Facebook login.")
            } else if user!.isNew { //inserted ! //
                println("User signed up and logged in through Facebook!")
            } else {
                println("User logged in through Facebook! \(user!.username)")
            }
        })
    }

    @IBAction func pressedLogout(sender: AnyObject) {
        PFUser.logOut()
        println(currentUser)
    }
    
    
    func getUserInfo(){
        if let sessions = PFFacebookUtils.session() {
            if sessions.isOpen {
                println("Sessions is open")
                FBRequestConnection.startForMeWithCompletionHandler({ (connection:FBRequestConnection!, result: AnyObject!, error:NSError!) -> Void in
                    if error != nil {
                        println("Facebook me request - error is not nil :(")
                    } else {
                        println("Facebook me request - error is nil :)")
                        let urlUserImage = "http://graph.facebook.com/\(result.objectID)/picture?type=large"
                        let firstName = result.first_name
                        let lastName = result.last_name
                        println("Firstname: \(result.firstName!)")
                        println(urlUserImage)
                    }
                })
            }
        } else {
            
        }
    }

    
    
}
