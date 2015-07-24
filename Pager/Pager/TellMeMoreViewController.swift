//
//  TellMeMoreViewController.swift
//  Pager
//
//  Created by Anuj Verma on 7/9/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class TellMeMoreViewController: UIViewController {

    @IBOutlet weak var tellMeMoreLabelTitle: UILabel!
    @IBOutlet weak var tellMoreInputField: UITextField!
    @IBOutlet weak var findSomeoneButton: UIButton!
    @IBOutlet weak var findSomeoneButtonBottomConstraint: NSLayoutConstraint!
    
    var initialBottom: CGFloat!
    let offset: CGFloat = 130

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        initialBottom = findSomeoneButtonBottomConstraint.constant
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
            self.findSomeoneButtonBottomConstraint.constant = self.initialBottom + self.offset
            self.findSomeoneButton.layoutIfNeeded()
            
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
            self.findSomeoneButtonBottomConstraint.constant = self.initialBottom
            self.findSomeoneButton.layoutIfNeeded()
            
            }, completion: nil)
    }

    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //I want the button to say skip when the tellMeMoreInputField is empty and say Find Me Someone when has text in it
    @IBAction func editingChanged(sender: AnyObject) {
        println(tellMoreInputField.text)
        if tellMoreInputField.text.isEmpty == true {
            findSomeoneButton.setTitle("Skip", forState: UIControlState.Normal)
        } else {
            findSomeoneButton.setTitle("Find me someone!", forState: UIControlState.Normal)
        }
    }

    //Dismisses the keyboard when you tap anywhere in the view
    @IBAction func onTap(sender: AnyObject) {
        tellMoreInputField.endEditing(true)

    }

    @IBAction func findSomeoneButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("findingSomeoneSegue", sender: self)
    }
    
}