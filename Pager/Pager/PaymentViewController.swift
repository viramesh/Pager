//
//  ChatEndedViewController.swift
//  Pager
//
//  Created by Anuj Verma on 8/2/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit
import Cosmos

class PaymentViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var tellUsMoreButton: UIButton!
    

    @IBOutlet weak var paymentExpertPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        dateTimeLabel.text = timestamp
               
        paymentExpertPhoto.layer.cornerRadius = paymentExpertPhoto.frame.size.width / 2;
        paymentExpertPhoto.clipsToBounds = true
        paymentExpertPhoto.layer.borderWidth = 2.0
        paymentExpertPhoto.layer.borderColor = CGColorCreateCopy(UIColor.whiteColor().CGColor)
        
        starRatingView.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.4, delay: 0.4, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.starRatingView.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
        
        starRatingView.didTouchCosmos = touchedTheStar
        tellUsMoreButton.hidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        let screenSize = UIScreen.mainScreen().bounds
        self.view.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
    }


    @IBAction func submitButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
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
            self.ratingLabel.hidden = true
            self.tellUsMoreButton.hidden = false
        } else {
            self.ratingLabel.hidden = false
            self.ratingLabel.text = "Woohoo! Awesome."
            self.tellUsMoreButton.hidden = true
        }
        //        self.ratingLabel.text = String(stringInterpolationSegment: rating)
    }
    @IBAction func tellUsMoreButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("feedbackSegue", sender: self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "feedbackSegue"){
            var ratingVC = segue.destinationViewController as! RatingViewController
            ratingVC.ratingNumberPassed = starRatingView.rating
        }
    }
}
