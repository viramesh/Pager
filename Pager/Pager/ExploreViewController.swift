//
//  ExploreViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 6/29/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet var exploreView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var exploreTableView: UITableView!
    var exploreTableViewCell: ExploreTableViewCell!
    var exploreImages = [String]()
    var exploreImageLabels = [String]()
    let TABLE_CELL_HEIGHT_PERCENTAGE:CGFloat = 0.48
    var TABLE_CELL_HEIGHT:CGFloat! // this value is set in viewdidload

    
    //screensize
    var screenSize: CGRect = CGRectZero
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    
    //for parallax-ing the images
    var topIndexRow:Int = 0
    var newYPos:CGFloat = 0
    let YPOS_START:CGFloat = -40
    let YPOS_END:CGFloat = 0
    var newGradientAlpha:CGFloat = 0.2
    let GRADIENT_ALPHA_START:CGFloat = 0.8
    let GRADIENT_ALPHA_END:CGFloat = 0.2
    
    //for custom transition into this VC
    var isPresenting: Bool = true
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize screensize variables
        screenSize = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        screenWidth = screenSize.width
        
        //setup table
        exploreTableView.dataSource = self
        exploreTableView.delegate = self
        exploreImages = ["landscaping", "gardening", "doors", "windows", "deck", "garage", "crack", "holes", "leak", "locks", "plumbing", "wallpainting", "decor", "appliances", "curtains", "electrical", "lighting", "wiring", "internet"]
        exploreImageLabels = ["Yard work", "Gardening", "Fix doors", "Repair windows", "Deck work", "Garage Doors", "Fix cracks", "Patch holes", "Fix leaks", "Change locks", "Plumbing Issues", "Paint walls", "Home decor", "Appliances", "Hang curtains", "Electrical issues", "Fix lighting", "Wiring issues", "Internet Problems"]
        TABLE_CELL_HEIGHT = screenHeight * TABLE_CELL_HEIGHT_PERCENTAGE
        
    }

    override func viewDidLayoutSubviews() {

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
    @IBAction func searchBtnDidPress(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "Search", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("SearchVC") as! SearchViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    
    /******************
    //  CUSTOM TRANSITION
    //  This part contains code for custom transitions into this VC
    *******************/
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        var fromViewControllerString = fromViewController.description
        
        //check if transitioning here from MainVC, and if yes, slide the mainVC down and show explore view
        if fromViewControllerString.rangeOfString("MainViewController") != nil{
            if (isPresenting) {
                containerView.addSubview(toViewController.view)
                toViewController.view.alpha = 0
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    toViewController.view.alpha = 1
                    }) { (finished: Bool) -> Void in
                        transitionContext.completeTransition(true)
                }

            } else {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    fromViewController.view.alpha = 0
                    }) { (finished: Bool) -> Void in
                        transitionContext.completeTransition(true)
                        fromViewController.view.removeFromSuperview()
                }
            }
        }
        
        //else if transitioning from other views, like the Searchview, just fade out old vc and fade in explorevc
        else {
            
            if (isPresenting) {
                containerView.addSubview(toViewController.view)
                toViewController.view.alpha = 0
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    toViewController.view.alpha = 1
                    }) { (finished: Bool) -> Void in
                        transitionContext.completeTransition(true)
                }
            } else {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    fromViewController.view.alpha = 0
                    }) { (finished: Bool) -> Void in
                        transitionContext.completeTransition(true)
                        fromViewController.view.removeFromSuperview()
                }
            }
        }
        
    }
        
    
    
    /******************
    //  TABLE VIEW
    //  This part contains code to populate the table view
    *******************/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return exploreImages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        exploreTableViewCell = tableView.dequeueReusableCellWithIdentifier("ExploreTableViewCellid") as! ExploreTableViewCell
        
        var yPos: CGFloat = 0
        var gradientAlpha:CGFloat = GRADIENT_ALPHA_END
        if(exploreTableViewCell.exploreImage == nil) {
            exploreTableViewCell.exploreImage = UIImageView()
        }
        
        if(indexPath.row < topIndexRow) {
            yPos = YPOS_END
            gradientAlpha = GRADIENT_ALPHA_END
        }
        else if(indexPath.row == topIndexRow) {
            yPos = newYPos
            gradientAlpha = newGradientAlpha
        }
        else {
            yPos = YPOS_START
            gradientAlpha = GRADIENT_ALPHA_START

        }

        var exploreImageFrame: CGRect = CGRectMake(0, yPos, screenWidth, screenHeight)
        exploreTableViewCell.exploreImage.frame = exploreImageFrame
        exploreTableViewCell.exploreImage.image = UIImage(named: exploreImages[indexPath.row])
        exploreTableViewCell.exploreImage.contentMode = UIViewContentMode.ScaleAspectFill
        exploreTableViewCell.exploreImageContainer.addSubview(exploreTableViewCell.exploreImage)
        exploreTableViewCell.exploreImageOverlayGradient.alpha = gradientAlpha
        exploreTableViewCell.exploreImageOverlayLabel.text = exploreImageLabels[indexPath.row] as String
        
        return exploreTableViewCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return self.TABLE_CELL_HEIGHT
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        println("table scrolled")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let visibleImages = exploreTableView.indexPathsForVisibleRows() as! [NSIndexPath]
        if visibleImages.count <= 1 {
            exploreTableView.reloadData()
            return
        }
        
        let rectInTableView: CGRect = exploreTableView.rectForRowAtIndexPath(visibleImages[1])
        let rectInSuperview: CGRect = exploreTableView.convertRect(rectInTableView, toView: exploreTableView.superview)
    
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenHeight = screenSize.height
        
        newYPos = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, Float(self.TABLE_CELL_HEIGHT), Float(YPOS_END), Float(YPOS_START)))
        
        newGradientAlpha = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, Float(self.TABLE_CELL_HEIGHT), Float(GRADIENT_ALPHA_END), Float(GRADIENT_ALPHA_START)))
        
        topIndexRow = visibleImages[1].row
        
        exploreTableView.reloadData()
        
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var visibleCells = exploreTableView.indexPathsForVisibleRows() as! [NSIndexPath]
        
        if(velocity.y <= 0 || visibleCells.count <= 1) {
            var rectInTableView: CGRect = exploreTableView.rectForRowAtIndexPath(visibleCells[0])
            targetContentOffset.memory.y = rectInTableView.origin.y
            
        }
        else {
            var rectInTableView: CGRect = exploreTableView.rectForRowAtIndexPath(visibleCells[1])
            targetContentOffset.memory.y = rectInTableView.origin.y
            
        }
        
    }
}
