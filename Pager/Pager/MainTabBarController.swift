//
//  MainTabBarController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/17/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    var button: UIButton = UIButton()
    var isHighLighted:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor(red: (102/255), green: (194/255), blue: (172/255), alpha: 1)
        self.tabBar.barTintColor = UIColor.whiteColor()
        //self.tabBar.clipsToBounds = true
        
        let itemAppearance = UITabBarItem.appearance()
        let attributesFont = [NSFontAttributeName:UIFont(name: "Avenir", size: 16)!, NSForegroundColorAttributeName:UIColor(red: (119/255), green: (119/255), blue: (119/255), alpha: 1)]
        itemAppearance.setTitleTextAttributes(attributesFont, forState: UIControlState.Normal)
        itemAppearance.setTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -12))
        
        let attributesFontSelected = [NSFontAttributeName:UIFont(name: "Avenir", size: 16)!, NSForegroundColorAttributeName:UIColor(red: (102/255), green: (194/255), blue: (172/255), alpha: 1)]
        itemAppearance.setTitleTextAttributes(attributesFontSelected, forState: UIControlState.Selected)
        
        self.delegate = self
        //println("aaa")
        var middleImage:UIImage = UIImage(named:"tab_search")!
        var highlightedMiddleImage:UIImage = UIImage(named:"tab_search_selected")!
        
        
        addCenterButtonWithImage(middleImage, highlightImage: highlightedMiddleImage)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: TABBAR DELEAGATE
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if !viewController.isKindOfClass(TabBarSearchViewController)
        {
            button.userInteractionEnabled = true
            button.highlighted = false
            button.selected = false
            isHighLighted = false
        }
        else {
            button.userInteractionEnabled = false
        }
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if  self.selectedViewController == viewController {
            println("Select one controller in tabbar twice")
            return false
        }
        
        return true
    }
    
    //MARK: MIDDLE TAB BAR HANDLER
    
    func addCenterButtonWithImage(buttonImage: UIImage, highlightImage:UIImage?)
    {
        
        let frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height)
        button = UIButton(frame: frame)
        button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        button.setBackgroundImage(highlightImage, forState: UIControlState.Highlighted)
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowOffset = CGSizeMake(0, -1)
        button.layer.shadowRadius = 0
        button.layer.shadowOpacity = 0.15
        
        var heightDifference:CGFloat = buttonImage.size.height - self.tabBar.frame.size.height
        if heightDifference < 0 {
            button.center = self.tabBar.center;
        }
        else
        {
            var center:CGPoint = self.tabBar.center;
            center.y = center.y - heightDifference/2.0;
            button.center = center;
        }
        
        button.addTarget(self, action: "changeTabToMiddleTab:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
    }
    
    
    func changeTabToMiddleTab(sender:UIButton)
    {
        
        var selectedIndex = Int(self.viewControllers!.count/2)
        self.selectedIndex = selectedIndex
        self.selectedViewController = (self.viewControllers as [AnyObject]?)?[selectedIndex] as? UIViewController
        dispatch_async(dispatch_get_main_queue(), {
            
            if self.isHighLighted == false{
                sender.highlighted = true;
                self.isHighLighted = true
            }else{
                sender.highlighted = false;
                self.isHighLighted = false
            }
        });
        
        sender.userInteractionEnabled = false
        
        //setTabBarVisible(true, animated: true)
        
    }
    
}
