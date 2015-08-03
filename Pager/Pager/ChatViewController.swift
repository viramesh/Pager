//
//  ChatViewController.swift
//  Pager
//
//  Created by Anuj Verma on 7/22/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var chatExpertPhoto: UIImageView!
    
    @IBOutlet weak var responseLabel1: UILabel!
    @IBOutlet weak var backgroundBubble1: UIImageView!
    
    @IBOutlet weak var responseLabel2: UILabel!
    @IBOutlet weak var backgroundBubble2: UIImageView!
    @IBOutlet weak var bubble3: UIView!
    @IBOutlet weak var textInputLabel: UITextField!
    
    @IBOutlet weak var textInputView: UIView!
    @IBOutlet weak var textInputViewBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
            dateLabel.text = timestamp
        
        // Make background bubbles hidden
        backgroundBubble1.alpha = 0
        backgroundBubble2.alpha = 0
        bubble3.alpha = 0
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        textInputLabel.becomeFirstResponder()
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
            self.textInputViewBottomConstraint.constant = kbSize.height
            self.textInputView.layoutIfNeeded()
            
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
            self.textInputViewBottomConstraint.constant = 0
            self.textInputView.layoutIfNeeded()
            
            }, completion: nil)
    }
    

    
    @IBAction func pressEndChatButton(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "Payment", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("paymentVC") as! PaymentViewController
        self.navigationController?.pushViewController(controller, animated: true)

    }

    @IBAction func sendButtonPressed(sender: AnyObject) {
        
        if (responseLabel1.text == "") {
            println("Field is blank")
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.responseLabel1.text = self.textInputLabel.text
                self.backgroundBubble1.alpha = 1
            })
            textInputLabel.text.removeAll(keepCapacity: true)
        } else {
            println("Field has text")
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.responseLabel2.text = self.textInputLabel.text
                self.backgroundBubble2.alpha = 1
                
            }, completion: { (Bool) -> Void in
                UIView.animateWithDuration(0.3, delay: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                    self.bubble3.alpha = 1
                }, completion: nil)
            })
            
            textInputLabel.text.removeAll(keepCapacity: true)
            
        }
    }

    @IBAction func onTap(sender: AnyObject) {
        textInputLabel.endEditing(true)
    }
    
    
    @IBAction func videoPressed(sender: AnyObject) {
        performSegueWithIdentifier("videoSegue", sender: self)

    }



}
