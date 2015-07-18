//
//  TabBarExploreViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/16/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class TabBarExploreViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    //screensize
    var screenSize: CGRect = CGRectZero
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    
    //exploreview controller
    var exploreVC:ExploreViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //initialize screensize variables
        screenSize = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        screenWidth = screenSize.width
     
        var storyboard = UIStoryboard(name: "Explore", bundle: nil)
        exploreVC = storyboard.instantiateViewControllerWithIdentifier("ExploreVC") as! ExploreViewController
        
        contentView.addSubview(exploreVC.view)
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
    @IBAction func toggleTabBar(sender: AnyObject) {
        setTabBarVisible(!tabBarIsVisible(), animated: true)

    }
    
    func setTabBarVisible(visible:Bool, animated:Bool) {
        
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        let searchButtonOffsetY = (visible ? 10 : -10)
        let searchButtonShadowRadius = (visible ? 0 : 2)

        // zero duration means no animation
        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            let tabBarC = self.tabBarController as! MainTabBarController
            
            UIView.animateWithDuration(duration) {
                tabBarC.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
                tabBarC.button.center.y = tabBarC.button.center.y + CGFloat(searchButtonOffsetY)
                tabBarC.button.layer.shadowRadius = CGFloat(searchButtonShadowRadius)

                return
            }
        }
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }

}
