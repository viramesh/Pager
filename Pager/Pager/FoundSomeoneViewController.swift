//
//  FoundSomeoneViewController.swift
//  Pager
//
//  Created by Anuj Verma on 7/15/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class FoundSomeoneViewController: UIViewController {
    
    @IBOutlet weak var expertPhoto: UIImageView!
    
    var progress: KDCircularProgress!
    
    var isPresenting: Bool = true
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.expertPhoto.transform = CGAffineTransformMakeScale(0, 0)
        
        setProgressCircle()

    }
    
    override func viewDidLayoutSubviews() {
        
        let screenSize = UIScreen.mainScreen().bounds
        self.view.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
        
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            
                self.expertPhoto.transform = CGAffineTransformMakeScale(1, 1)
            
            }, completion: { (Bool) -> Void in
                
                self.progress.animateToAngle(360, duration: 0.4, completion: nil)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func tappedGetStarted(sender: AnyObject) {
        //transition to LoginViewController
//        var storyboard = UIStoryboard(name: "Login", bundle: nil)
//        var controller = storyboard.instantiateViewControllerWithIdentifier("loginVC") as! LoginViewController
//        self.presentViewController(controller, animated: true, completion: nil)
        performSegueWithIdentifier("chatSegue", sender: self)
    }

}
