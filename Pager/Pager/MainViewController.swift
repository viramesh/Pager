//
//  MainViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 6/29/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var logoBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.animateLogoBackground()
    }
    
    func gotoExploreVC() {
        var storyboard = UIStoryboard(name: "Explore", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("ExploreVC") as! ExploreViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func animateLogoBackground() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        var circle:UIView = UIView()
        circle.frame = CGRectMake(0, 0, 64, 64)
        circle.layer.cornerRadius = 32
        circle.center.x = screenSize.width / 2
        circle.center.y = screenSize.height / 2
        circle.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        circle.alpha = 0.8
        
        logoBackgroundView.addSubview(circle)

        let options = UIViewAnimationOptions.CurveEaseInOut
        
        UIView.animateWithDuration(1.0, delay: 0, options: options, animations: { () -> Void in
            circle.transform = CGAffineTransformMakeScale(2.5, 2.5)
            circle.alpha = 0.1
        }) { (Bool) -> Void in
            UIView.animateWithDuration(1.0, delay: 0, options: options, animations: { () -> Void in
                circle.transform = CGAffineTransformMakeScale(1, 1)
                circle.alpha = 0.8
                }) { (Bool) -> Void in
                    circle.alpha = 0
                    self.gotoExploreVC()
            }
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
