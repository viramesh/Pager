//
//  SearchToTellMeMoreTransition.swift
//  Pager
//
//  Created by Anuj Verma on 7/22/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class SearchToTellMeMoreTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    let duration:NSTimeInterval = 0.4
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //println("Doing search to tellmemore transition")
        self.transitionContext = transitionContext
        
        var containerView = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! SearchViewController!
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! TellMeMoreViewController!
        
        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        
        fromViewController.button.hidden = true
        toViewController.tellMeMoreLabelTitle.hidden = true
        
        var movingTextLabel = UILabel(frame: fromViewController.button.frame)
        movingTextLabel.text = fromViewController.textString
        containerView.addSubview(movingTextLabel)
        toViewController.tellMeMoreLabelTitle.text = fromViewController.textString!
        
        UIView.animateWithDuration(self.duration, animations: { () -> Void in
            toViewController.view.alpha = 1
            
            //Set label on view controller to be text from button on SearchViewController
            movingTextLabel.frame = toViewController.tellMeMoreLabelTitle.frame
            movingTextLabel.font = toViewController.tellMeMoreLabelTitle.font
            }) { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
                toViewController.tellMeMoreLabelTitle.hidden = false
                fromViewController.button.hidden = false
                movingTextLabel.removeFromSuperview()
                
        }

        
    }
}
