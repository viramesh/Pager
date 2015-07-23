//
//  FoundSomeoneToChatTransition.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/21/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class FoundSomeoneToChatTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    let duration:NSTimeInterval = 0.4
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //println("Doing search to chat transition")
        self.transitionContext = transitionContext
        
        var containerView = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! FoundSomeoneViewController!
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ChatViewController!
        
        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        
        fromViewController.expertPhoto.hidden = true
        toViewController.chatExpertPhoto.hidden = true
        
        var movingProImageView: UIImageView!
        movingProImageView = UIImageView(frame: fromViewController.expertPhoto.frame)
        movingProImageView.image = fromViewController.expertPhoto.image
        movingProImageView.contentMode = fromViewController.expertPhoto.contentMode
        movingProImageView.clipsToBounds = fromViewController.expertPhoto.clipsToBounds
    
        containerView.addSubview(movingProImageView)
        toViewController.chatExpertPhoto.image = fromViewController.expertPhoto.image
        
        UIView.animateWithDuration(self.duration, animations: { () -> Void in
            toViewController.view.alpha = 1
            
            //Set label on view controller to be text from button on SearchViewController
            movingProImageView.frame = toViewController.chatExpertPhoto.frame
            }) { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
                toViewController.chatExpertPhoto.hidden = false
                fromViewController.expertPhoto.hidden = false
                movingProImageView.removeFromSuperview()
                
        }

        
    }
}
