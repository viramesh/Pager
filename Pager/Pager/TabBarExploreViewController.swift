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
        
        displayViewController(exploreVC)

    }
    
    override func viewDidLayoutSubviews() {
        contentView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
    }
    
    override func viewWillAppear(animated: Bool) {
        setTabBarVisible(true, true, true, self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func displayViewController(content: UIViewController) {
        addChildViewController(content)
        self.contentView.addSubview(content.view)
        content.didMoveToParentViewController(self)
    }
    
    func hideViewController(content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    

    func exploreViewDidPan(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        println("\(point) & \(velocity)")
        
        if sender.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Changed {
            println("Gesture changed at: \(point)")
        } else if sender.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
        }
    }
    
//    func setTabBarVisible(visible:Bool, animated:Bool) {
//        
//        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
//        
//        // bail if the current state matches the desired state
//        if (tabBarIsVisible() == visible) { return }
//        
//        // get a frame calculation ready
//        let frame = self.tabBarController?.tabBar.frame
//        let height = frame?.size.height
//        let offsetY = (visible ? -height! : height)
//        let searchButtonOffsetY = (visible ? 10 : -10)
//        let searchButtonShadowRadius = (visible ? 0 : 2)
//
//        // zero duration means no animation
//        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
//        
//        //  animate the tabBar
//        if frame != nil {
//            let tabBarC = self.tabBarController as! MainTabBarController
//            
//            UIView.animateWithDuration(duration) {
//                tabBarC.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
//                tabBarC.button.center.y = tabBarC.button.center.y + CGFloat(searchButtonOffsetY)
//                tabBarC.button.layer.shadowRadius = CGFloat(searchButtonShadowRadius)
//
//                return
//            }
//        }
//    }
//    
//    func tabBarIsVisible() ->Bool {
//        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
//    }

}
