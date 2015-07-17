//
//  TabBarAccountViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/17/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class TabBarAccountViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    //screensize
    var screenSize: CGRect = CGRectZero
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    
    //exploreview controller
    var accountVC:LoginViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        //initialize screensize variables
        screenSize = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        screenWidth = screenSize.width
        
        var storyboard = UIStoryboard(name: "Login", bundle: nil)
        accountVC = storyboard.instantiateViewControllerWithIdentifier("loginVC") as! LoginViewController
        
        contentView.addSubview(accountVC.view)
    }
    
    override func viewDidLayoutSubviews() {
        contentView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
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

}
