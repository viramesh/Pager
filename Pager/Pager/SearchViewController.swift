//
//  SearchViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 6/29/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var searchResultButton1: UIButton!
    @IBOutlet weak var searchResultButton2: UIButton!
    @IBOutlet weak var searchResultButton3: UIButton!
    @IBOutlet weak var findButton: UIButton!
    
    var initialY: CGFloat!
    let offset: CGFloat = -130
    
    var isPresenting: Bool = true

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting all results labels alphas to 0.
        searchResultButton1.alpha = 0
        searchResultButton2.alpha = 0
        searchResultButton3.alpha = 0

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        //set the initial y position of findButton
        initialY = findButton.frame.origin.y
        
        
        

        
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
    
    
    @IBAction func editSearchTextField(sender: AnyObject) {
        
        //hardcoded so that when you type in mo to the TextField it animates the results pop up.
         if searchTextField.text == "mo" {
            
            //animate result button 1
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.searchResultButton1.alpha = 1
            
            //animate result button 2
            UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.searchResultButton2.alpha = 1
                }, completion: nil)
               
            //animate label 3
            UIView.animateWithDuration(0.2, delay: 0.4, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.searchResultButton3.alpha = 1
                }, completion: nil)

            })
            
         }
         //if searchTextField is blank the resultLabels dissappear
        else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.searchResultButton1.alpha = 0
                self.searchResultButton2.alpha = 0
                self.searchResultButton3.alpha = 0
            })
            
            
        }
    }
    
    
    @IBAction func exploreBtnDidPress(sender: AnyObject) {
    
        var storyboard = UIStoryboard(name: "Explore", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("ExploreVC") as! ExploreViewController
        self.presentViewController(controller, animated: true, completion: nil)
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
    
    func keyboardWillShow(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        var animationCurve = curveValue.integerValue
        
        println(kbSize)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
            self.findButton.frame.origin = CGPoint(x: self.findButton.frame.origin.x, y: self.initialY + self.offset)

            
            }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
            self.findButton.frame.origin = CGPoint(x: self.findButton.frame.origin.x, y: self.initialY)

            }, completion: nil)
    }

    
    @IBAction func onTap(sender: AnyObject) {
        searchTextField.endEditing(true)

    }
    
    

    @IBAction func didPressResultButton(sender: AnyObject) {
        performSegueWithIdentifier("tellMeMoreSegue", sender: self)
    }
    
}
