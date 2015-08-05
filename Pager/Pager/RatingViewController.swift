//
//  RatingViewController.swift
//  Pager
//
//  Created by Anuj Verma on 8/5/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit
import Cosmos

class RatingViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var starRatingView: CosmosView!
    
    var ratingNumberPassed: Double!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        starRatingView.didTouchCosmos = touchedTheStar
        starRatingView.rating = ratingNumberPassed
        feedbackTextView.delegate = self
        setFeedbackTextView()
        setLabel()

        
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
            self.ratingLabel.text = "Woohoo! Awesome, tell us what went well!"
            feedbackTextView.hidden = false
        }
        //        self.ratingLabel.text = String(stringInterpolationSegment: rating)
    }
    
    func setLabel(){
        if ratingNumberPassed < 3 {
            self.ratingLabel.text = "Oh no, let us know what went wrong."
        } else{
            self.ratingLabel.text = "Woohoo! Awesome, tell us what went well!"
        }
    }
    
    func setFeedbackTextView(){
        feedbackTextView.hidden = false
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
    @IBAction func pressedBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    @IBAction func submitButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)

    }
}
