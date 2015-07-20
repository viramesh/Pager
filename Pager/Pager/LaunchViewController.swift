//
//  LaunchViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/14/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var logoBackgroundView: UIView!
    var logoImageView: UIImageView!
    
    //screensize
    var screenSize: CGRect = CGRectZero
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    
    //logosize
    var logoWidth:CGFloat = 64
    var logoHeight:CGFloat = 64
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize screensize variables
        screenSize = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        screenWidth = screenSize.width
        
        //initialize logo in center of screen
        logoImageView = UIImageView()
        logoImageView.frame = CGRectMake(screenWidth/2-logoWidth/2, screenHeight/2-logoHeight/2, logoWidth, logoHeight)
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        let delay =  0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            //segue into mainVC
            self.performSegueWithIdentifier("LaunchMainVC", sender: self)
        }
    }
    
    override func viewDidLayoutSubviews() {
        logoBackgroundView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
        logoBackgroundView.addSubview(logoImageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
