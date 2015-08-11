//
//  FindingSomeoneViewController.swift
//  Pager
//
//  Created by Anuj Verma on 7/11/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit
import Foundation

class FindingSomeoneViewController: UIViewController {

    @IBOutlet weak var loadingP: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    var timer: NSTimer!

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
    
    override func viewDidLayoutSubviews() {
        let screenSize = UIScreen.mainScreen().bounds
        self.view.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
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

    @IBAction func closeButtonTapped(sender: AnyObject) {
        println(self.parentViewController)
        //dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func toFoundSomeoneVC() {
        self.performSegueWithIdentifier("foundSomeoneSegue", sender: self)
    }

}
