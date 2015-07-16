//
//  FindingSomeoneViewController.swift
//  Pager
//
//  Created by Anuj Verma on 7/11/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit
import Foundation

class FindingSomeoneViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true

    @IBOutlet weak var loadingP: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    var timer: NSTimer!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set close button scale and alpha to 0
        closeButton.alpha = 0
        closeButton.transform = CGAffineTransformMakeScale(0, 0)

        // Do any additional setup after loading the view.
        
        //Animation for the loading P
        
        self.loadingP.animationImages = [UIImage]()
        for var index = 0; index < 40; index++ {
            var frameName = String(format: "Loading-%03d", index)
            self.loadingP.animationImages?.append(UIImage(named: frameName)!)
        }

        self.loadingP.animationDuration = 1.2
        self.loadingP.startAnimating()
        
        //End Animation for loading P
        

    }
    
    override func viewDidAppear(animated: Bool) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "toFoundSomeoneVC", userInfo: nil, repeats: false)

        
       UIView.animateKeyframesWithDuration(0.2, delay: 0.4, options: UIViewKeyframeAnimationOptions.AllowUserInteraction, animations: { () -> Void in
        self.closeButton.alpha = 1
        self.closeButton.transform = CGAffineTransformMakeScale(1, 1)
       }, completion: nil)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }       

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }

    @IBAction func closeButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func toFoundSomeoneVC() {
        self.performSegueWithIdentifier("foundSomeoneSegue", sender: self)
    }

}
