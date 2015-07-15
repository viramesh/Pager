//
//  MainViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 6/29/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    //screensize
    var screenSize: CGRect = CGRectZero
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    
    //colors
    let COLOR_DEFAULT:UIColor = UIColor(red: 74, green: 74, blue: 74, alpha: 1)
    let COLOR_ACTIVE:UIColor = UIColor(red: 77, green: 205, blue: 176, alpha: 1)
    
    //child view controllers
    var exploreVC:ExploreViewController!
    var searchVC:SearchViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize screensize variables
        screenSize = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        screenWidth = screenSize.width
        
        //load explore VC
        var storyboard = UIStoryboard(name: "Explore", bundle: nil)
        exploreVC = storyboard.instantiateViewControllerWithIdentifier("ExploreVC") as! ExploreViewController
        displayViewController(exploreVC)

        
        //instantiate search VC
        storyboard = UIStoryboard(name: "Search", bundle: nil)
        searchVC = storyboard.instantiateViewControllerWithIdentifier("SearchVC") as! SearchViewController
    
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayViewController(content: UIViewController) {
        addChildViewController(content)
        self.contentView.addSubview(content.view)
        content.didMoveToParentViewController(self)
    }
    
    func hideViewController(content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func searchBtnDidPress(sender: AnyObject) {
        displayViewController(searchVC)
        hideViewController(exploreVC)
    }

    @IBAction func homeBtnDidPress(sender: AnyObject) {
        displayViewController(exploreVC)
        hideViewController(searchVC)
    }
}
