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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
            dateLabel.text = timestamp
        
        // Make background bubbles hidden
        backgroundBubble1.alpha = 0
        backgroundBubble2.alpha = 0
        bubble3.alpha = 0
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
    @IBAction func pressEndChatButton(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
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

}
