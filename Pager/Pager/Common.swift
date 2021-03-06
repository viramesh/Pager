//
//  Common.swift
//  test
//
//  Created by Timothy Lee on 10/21/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit

func CGAffineTransformMakeDegreeRotation(rotation: CGFloat) -> CGAffineTransform {
    return CGAffineTransformMakeRotation(rotation * CGFloat(M_PI / 180))
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
    var ratio = (r2Max - r2Min) / (r1Max - r1Min)
    return value * ratio + r2Min - r1Min * ratio
}


/* For managing tab bar visibility from child view controllers */

func setTabBarVisible(visible:Bool, animated:Bool, searchTabVisible:Bool, controller: UIViewController) {
    
    // bail if the current state matches the desired state
    if (tabBarIsVisible(controller) == visible) { return }
    
    // get a frame calculation ready
    let frame = controller.tabBarController?.tabBar.frame
    let height = frame?.size.height
    let offsetY = (visible ? -height! : height)
    
    // figure out searchButtonOffsetY and shadowRadius
    var searchButtonOffsetY:CGFloat! = 0
    var searchButtonShadowRadius: CGFloat! = 0
    
    if(visible) {
        searchButtonOffsetY = 0
        searchButtonShadowRadius = 0
    }
    else {
        if(searchTabVisible) {
            searchButtonOffsetY = -60
            searchButtonShadowRadius = 2
        }
        else {
            searchButtonOffsetY = height
            searchButtonShadowRadius = 0
        }
    }

    // zero duration means no animation
    let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
    
    //  animate the tabBar
    if frame != nil {
        let tabBarC = controller.tabBarController as! MainTabBarController
        
        if visible==true {
            tabBarC.tabBar.alpha = 1
            tabBarC.tabBar.hidden = false
            tabBarC.tabBar.userInteractionEnabled = true
            //println("preparing to show tab bar")
        }
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            tabBarC.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
            tabBarC.button[0].center.y = tabBarC.button[0].center.y + offsetY!
            tabBarC.button[2].center.y = tabBarC.button[2].center.y + offsetY!
            tabBarC.button[1].center.y = tabBarC.button[1].center.y + offsetY!
            //tabBarC.button[1].center.y = tabBarC.tabBar.center.y + searchButtonOffsetY
            //tabBarC.button[1].layer.shadowRadius = CGFloat(searchButtonShadowRadius)
            return

        }, completion: { (Bool) -> Void in
            if visible==false {
                //tabBarC.tabBar.alpha = 0
                //tabBarC.tabBar.hidden = true
                //tabBarC.tabBar.userInteractionEnabled = false
                //println("hid the tabbar")
            }
        })
        
        
    }
}

func setTabBarTranslucent(translucency:Bool, controller: UIViewController) {
    controller.tabBarController?.tabBar.translucent = translucency
}

func tabBarIsVisible(controller: UIViewController) ->Bool {
    return controller.tabBarController?.tabBar.frame.origin.y <= CGRectGetMaxY(controller.view.frame)
}

func getTabBarHeight(controller: UIViewController) -> CGFloat {
    return controller.tabBarController!.tabBar.frame.height
}
