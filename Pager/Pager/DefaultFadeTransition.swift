//
//  DefaultFadeTransition.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/21/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class DefaultFadeTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    let duration:NSTimeInterval = 0.4
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        var containerView = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
        
        toViewController.view.alpha = 0
        containerView.addSubview(toViewController.view)
        
        UIView.animateWithDuration(self.duration, animations: { () -> Void in
            fromViewController.view.alpha = 0
            toViewController.view.alpha = 1
            }) { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
                //fromViewController.view.removeFromSuperview()
        }
        
    }
}
