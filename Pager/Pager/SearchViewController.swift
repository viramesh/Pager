//
//  SearchViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 6/29/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var searchResultButton1: UIButton!
    @IBOutlet weak var searchResultButton2: UIButton!
    @IBOutlet weak var searchResultButton3: UIButton!
    @IBOutlet weak var findButton: UIButton!
    
    var textString: String!
    var button: UIButton!
    
    var initialY: CGFloat!
    let offset: CGFloat = -130
    
    var isPresenting: Bool = true

//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        modalPresentationStyle = UIModalPresentationStyle.Custom
//        transitioningDelegate = self
//    }
    
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
    
    override func viewWillAppear(animated: Bool) {
        showMainTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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

    //Action when pushing any of the result buttons that display under the input field
    @IBAction func didPressResultButton(sender: AnyObject) {
        
        //set button
        button = sender as! UIButton
        
        //set text of button pressed equal to textString variable
        textString = (button.titleLabel?.text)!
        
        //transition to TellMeMoreViewController
        var storyboard = UIStoryboard(name: "Chat", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("tellMeMoreVC") as! TellMeMoreViewController
//        controller.tellMeMoreLabelTitle.text = textString
        self.navigationController?.pushViewController(controller, animated: true)

        hideMainTabBar()
        resetSearchView()
    }
    
    func showMainTabBar() {
        let parentVC = self.parentViewController as! SearchNavigationController
        let grandParentVC = parentVC.parentViewController as! TabBarSearchViewController
        setTabBarVisible(true, true, true, grandParentVC)
    }
    
    func hideMainTabBar() {
        let parentVC = self.parentViewController as! SearchNavigationController
        let grandParentVC = parentVC.parentViewController as! TabBarSearchViewController
        setTabBarVisible(false, true, false, grandParentVC)
    }
    
    func resetSearchView() {
        searchTextField.text = ""
        searchResultButton1.alpha = 0
        searchResultButton2.alpha = 0
        searchResultButton3.alpha = 0
    }
    

}
