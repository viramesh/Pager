//
//  MainTabBarController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/17/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    let buttonHeightPercentage = 0.6
    let buttonWidthPercentage = 0.85
    var isHighLighted: [Bool] = [false, false, false]
    var button: [UIButton] = [UIButton(), UIButton(), UIButton()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor(red: (102/255), green: (194/255), blue: (172/255), alpha: 1)
        self.tabBar.barTintColor = UIColor.whiteColor()
        self.tabBar.translucent = false
        
        self.delegate = self
        
        addButton(0, buttonLabel: "EXPLORE")
        addButton(1, buttonLabel: "PAGE A PRO")
        addButton(2, buttonLabel: "ACCOUNT")


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    //MARK: TABBAR DELEAGATE
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if viewController.isKindOfClass(TabBarExploreViewController) {
            highlightButton(0)
            deselectButton(1)
            deselectButton(2)
        }
        else if viewController.isKindOfClass(TabBarSearchViewController) {
            deselectButton(0)
            highlightButton(1)
            deselectButton(2)
        }
        else {
            deselectButton(0)
            deselectButton(1)
            highlightButton(2)
        }
    }
    
    func deselectButton(i: Int) {
        button[i].userInteractionEnabled = true
        isHighLighted[i] = false
        button[i].backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button[i].setTitleColor(UIColor(red: (119/255), green: (119/255), blue: (119/255), alpha: 1), forState: UIControlState.Normal)
    }
    
    func highlightButton(i: Int) {
        button[i].userInteractionEnabled = false
        isHighLighted[i] = true
        button[i].backgroundColor = UIColor(red: (102/255), green: (194/255), blue: (172/255), alpha: 1)
        button[i].setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), forState: UIControlState.Normal)

    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if  self.selectedViewController == viewController {
            println("Select one controller in tabbar twice")
            return false
        }
        
        return true
    }
    
    //MARK: MIDDLE TAB BAR HANDLER
    func addButton(pos: Int, buttonLabel: String)
    {
        
        let frame = CGRectMake(0.0, 0.0, self.tabBar.frame.width / 3 * CGFloat(self.buttonWidthPercentage), self.tabBar.frame.height * CGFloat(self.buttonHeightPercentage))
        button[pos] = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button[pos].frame = frame
        button[pos].tag = pos
        button[pos].clipsToBounds = true
        button[pos].backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        button[pos].setTitle(buttonLabel, forState: UIControlState.Normal)
        button[pos].titleLabel!.font = UIFont(name: "Avenir", size: 12)
        button[pos].setTitleColor(UIColor(red: (119/255), green: (119/255), blue: (119/255), alpha: 1), forState: UIControlState.Normal)
        button[pos].layer.cornerRadius = self.tabBar.frame.height * CGFloat( self.buttonHeightPercentage / 2)
        button[pos].layer.shadowColor = UIColor.blackColor().CGColor
        button[pos].layer.shadowOffset = CGSizeMake(0, 0)
        button[pos].layer.shadowRadius = 0
        button[pos].layer.shadowOpacity = 0.15

        button[pos].center.x = (self.tabBar.frame.width / 3) * (CGFloat(pos) + 0.5)
        button[pos].frame.origin.y = self.tabBar.frame.origin.y + self.tabBar.frame.height * CGFloat((1-self.buttonHeightPercentage)/2)
        
        button[pos].addTarget(self, action: "changeTab:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button[pos])
        if(pos == 0) {
            highlightButton(pos)
        }
        else {
            deselectButton(pos)
        }
    }
    
    
    func changeTab(sender:UIButton)
    {
        
        self.selectedIndex = sender.tag
        self.selectedViewController = (self.viewControllers as [AnyObject]?)?[selectedIndex] as? UIViewController
        dispatch_async(dispatch_get_main_queue(), {
            
            for i in 0...2 {
                if i == self.selectedIndex {
                    self.highlightButton(i)
                    sender.highlighted = true
                }
                else {
                    self.deselectButton(i)
                }
            }
            
        });
        
        
    }
    
}
