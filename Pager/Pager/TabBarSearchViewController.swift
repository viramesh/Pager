//
//  TabBarSearchViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/17/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class TabBarSearchViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    //screensize
    var screenSize: CGRect = CGRectZero
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    
    //exploreview controller
    var searchNC:SearchNavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //initialize screensize variables
        screenSize = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        screenWidth = screenSize.width
        
        var storyboard = UIStoryboard(name: "Search", bundle: nil)
        searchNC = storyboard.instantiateViewControllerWithIdentifier("searchNC") as! SearchNavigationController
    }
    
    override func viewDidLayoutSubviews() {
        contentView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
        displayViewController(searchNC)
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
    

}
