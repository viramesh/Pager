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
    
    //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
    
    // bail if the current state matches the desired state
    if (tabBarIsVisible(controller) == visible) { return }
    
    // get a frame calculation ready
    let frame = controller.tabBarController?.tabBar.frame
    let height = frame?.size.height
    let offsetY = (visible ? -height! : height)
    
    // figure out searchButtonOffsetY
    var searchButtonOffsetY:CGFloat! = 0
    if(visible) {
        searchButtonOffsetY = -10
    }
    else {
        if(searchTabVisible) {
            searchButtonOffsetY = -100
        }
        else {
            searchButtonOffsetY = height
        }
    }
    
    //let searchButtonShadowRadius = (visible ? 0 : 2)
    
    // zero duration means no animation
    let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
    
    //  animate the tabBar
    if frame != nil {
        let tabBarC = controller.tabBarController as! MainTabBarController
        
        UIView.animateWithDuration(duration) {
            tabBarC.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
            tabBarC.button.frame.origin.y = tabBarC.tabBar.frame.origin.y + searchButtonOffsetY
            //tabBarC.button.layer.shadowRadius = CGFloat(searchButtonShadowRadius)
            
            return
        }
    }
}

func tabBarIsVisible(controller: UIViewController) ->Bool {
    return controller.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(controller.view.frame)
}
