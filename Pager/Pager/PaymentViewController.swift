//
//  ChatEndedViewController.swift
//  Pager
//
//  Created by Anuj Verma on 8/2/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit
import Cosmos

class PaymentViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var paymentExpertPhoto: UIImageView!
    @IBOutlet weak var starRatingView: CosmosView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        dateTimeLabel.text = timestamp
        starRatingView.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.4, delay: 0.4, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.starRatingView.transform = CGAffineTransformMakeScale(1, 1)
        }, completion: nil)
        
        paymentExpertPhoto.layer.cornerRadius = paymentExpertPhoto.frame.size.width / 2;
        paymentExpertPhoto.clipsToBounds = true
        paymentExpertPhoto.layer.borderWidth = 2.0
        paymentExpertPhoto.layer.borderColor = CGColorCreateCopy(UIColor.whiteColor().CGColor)
        
        starRatingView.didTouchCosmos = touchedTheStar
        feedbackTextView.hidden = true
        feedbackTextView.delegate = self
        setFeedbackTextView()
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
    private func touchedTheStar(rating: Double) {
        
        if starRatingView.rating < 3 {
            println("Rating is 1")
            self.ratingLabel.text = "Oh no, let us know what went wrong."
            feedbackTextView.hidden = false
        } else {
            self.ratingLabel.text = "Woohoo! Awesome."
            feedbackTextView.hidden = true
        }
//        self.ratingLabel.text = String(stringInterpolationSegment: rating)
    }
    
    func setFeedbackTextView(){
        feedbackTextView.hidden = true
        feedbackTextView.text = "Please leave feedback here."
        feedbackTextView.textColor = UIColor.lightGrayColor()
    }

    func textViewDidBeginEditing(textView: UITextView) {
        if feedbackTextView.textColor == UIColor.lightGrayColor() {
            feedbackTextView.text = nil
            feedbackTextView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if feedbackTextView.text.isEmpty {
            feedbackTextView.text = "Please leave feedback here."
            feedbackTextView.textColor = UIColor.lightGrayColor()
        }
    }
}
