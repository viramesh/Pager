//
//  FoundSomeoneViewController.swift
//  Pager
//
//  Created by Anuj Verma on 7/15/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class FoundSomeoneViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    @IBOutlet weak var expertPhoto: UIImageView!
    
    var progress: KDCircularProgress!

    
    var isPresenting: Bool = true

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.expertPhoto.transform = CGAffineTransformMakeScale(0, 0)
        
        setProgressCircle()
        
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
                
                //start animation block for expertPhoto
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                    //
                    self.expertPhoto.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { (Bool) -> Void in
                    //
                    self.progress.animateToAngle(360, duration: 0.5, completion: nil)
                })
                //end animation block for expertPhoto
                
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

    func setProgressCircle(){
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 132, height: 132))
        progress.startAngle = -90
        progress.progressThickness = 0.15
        progress.trackThickness = 0
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .Forward
        progress.glowAmount = 0
        progress.setColors(UIColor(red: 77/255, green: 205/255, blue: 176/255, alpha: 1))
        progress.center = CGPoint(x: expertPhoto.center.x, y: expertPhoto.center.y)
        view.addSubview(progress)
    }
    

    @IBAction func pressDismissButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
