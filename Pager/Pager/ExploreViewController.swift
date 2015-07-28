//
//  ExploreViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/27/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    let COLOR_GREEN: UIColor = UIColor(red: 77/255, green: 205/255, blue: 176/255, alpha: 1)
    let COLOR_GRAY: UIColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1)
    
    var pageViewController : UIPageViewController!
    var count = 0

    var exploreImages = [
        ["landscaping", "gardening", "doors", "windows", "deck", "garage", "crack", "holes", "leak", "locks", "plumbing", "wallpainting", "decor", "appliances", "curtains", "electrical", "lighting", "wiring", "internet"],
        ["landscaping", "gardening", "doors", "windows", "deck", "garage", "crack", "holes", "leak", "locks", "plumbing", "wallpainting", "decor", "appliances", "curtains", "electrical", "lighting", "wiring", "internet"],
        ["landscaping", "gardening", "doors", "windows", "deck", "garage", "crack", "holes", "leak", "locks", "plumbing", "wallpainting", "decor", "appliances", "curtains", "electrical", "lighting", "wiring", "internet"]
        ]
    
    
    var exploreImageLabels = [
        ["Yard work", "Gardening", "Fix doors", "Repair windows", "Deck work", "Garage Doors", "Fix cracks", "Patch holes", "Fix leaks", "Change locks", "Plumbing Issues", "Paint walls", "Home decor", "Appliances", "Hang curtains", "Electrical issues", "Fix lighting", "Wiring issues", "Internet Problems"],
        ["Yard work", "Gardening", "Fix doors", "Repair windows", "Deck work", "Garage Doors", "Fix cracks", "Patch holes", "Fix leaks", "Change locks", "Plumbing Issues", "Paint walls", "Home decor", "Appliances", "Hang curtains", "Electrical issues", "Fix lighting", "Wiring issues", "Internet Problems"],
        ["Yard work", "Gardening", "Fix doors", "Repair windows", "Deck work", "Garage Doors", "Fix cracks", "Patch holes", "Fix leaks", "Change locks", "Plumbing Issues", "Paint walls", "Home decor", "Appliances", "Hang curtains", "Electrical issues", "Fix lighting", "Wiring issues", "Internet Problems"]
        ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        /* Getting the page View controller */
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("explorePageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        
        let exploreTableViewController: ExploreTableViewController = self.viewControllerAtIndex(0) as! ExploreTableViewController
        self.pageViewController.setViewControllers([exploreTableViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.addChildViewController(pageViewController)
        self.contentView.addSubview(pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
        var index = (viewController as! ExploreTableViewController).pageIndex!
        index++
        if(index >= self.exploreImages.count){
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    
        var index = (viewController as! ExploreTableViewController).pageIndex!
        if(index <= 0){
            return nil
        }
        index--
        
        return self.viewControllerAtIndex(index)
    
    }
    
    func viewControllerAtIndex(index : Int) -> UIViewController? {
        if((self.exploreImages.count == 0) || (index >= self.exploreImages.count)) {
            return nil
        }
    
        let exploreTableViewController: ExploreTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("exploreTableVC") as! ExploreTableViewController
    
        exploreTableViewController.exploreImages = self.exploreImages[index]
        exploreTableViewController.exploreImageLabels = self.exploreImageLabels[index]
        exploreTableViewController.pageIndex = index
        
        return exploreTableViewController
    }
    
    
    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return self.exploreImages.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return 0
//    }

}
