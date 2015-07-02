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
    @IBOutlet weak var searchButtonCircleView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var exploreTableView: UITableView!
    var exploreTableViewCell: ExploreTableViewCell!
    var exploreImages = [String]()
    var exploreImageLabels = [String]()

    //screensize
    var screenSize: CGRect = CGRectZero
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
   
    
    //for parallax-ing the images
    var topIndexRow:Int = 0
    var newYPos:CGFloat = 0
    let YPOS_START:CGFloat = -80
    let YPOS_END:CGFloat = 0
    let SECOND_IMAGE_HEIGHT:CGFloat = 80
    var newGradientAlpha:CGFloat = 0.2
    let GRADIENT_ALPHA_START:CGFloat = 1
    let GRADIENT_ALPHA_END:CGFloat = 0.2
    
    //for custom transition into this VC
    var isPresenting: Bool = true
    
    //for animating search button into place
    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    var snap: UISnapBehavior!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    var attach: UIAttachmentBehavior!
    
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

        exploreTableView.dataSource = self
        exploreTableView.delegate = self
        exploreImages = ["crack", "holes", "leak", "locks", "plumbing", "wallpainting"]
        exploreImageLabels = ["Fix cracks", "Patch holes", "Fix leaks", "Change locks", "Plumbing Issues", "Paint walls"]
    
        searchButtonCircleView.layer.cornerRadius = 32
        searchButtonCircleView.frame = CGRectMake(screenWidth/2-32, screenHeight/2-32, 64, 64)
        
        println(UIScreen.mainScreen().bounds)
    }

    override func viewDidLayoutSubviews() {
        searchButtonCircleView.frame = CGRectMake(screenWidth/2-32, screenHeight/2-32, 64, 64)
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
        
        //check if transitioning here from MainVC, and if yes, animate the search button in place
        if fromViewControllerString.rangeOfString("MainViewController") != nil{
            if (isPresenting) {
                containerView.addSubview(toViewController.view)
                toViewController.view.alpha = 0
                searchButton.alpha = 0
                searchButtonCircleView.alpha = 1
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    toViewController.view.alpha = 1
                    }) { (finished: Bool) -> Void in
                        self.animateSearchButtonInPlace()
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
        
        else {
            
            self.searchButtonCircleView.alpha = 0

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
    
    func animateSearchButtonInPlace() {
        let path = UIBezierPath()
        path.moveToPoint(self.searchButtonCircleView.center)
        path.addCurveToPoint(self.searchButton.center, controlPoint1: CGPoint(x: 136, y: 373), controlPoint2: CGPoint(x: 178, y: 110))
        
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.CGPath
        anim.duration = 1.0
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        anim.calculationMode = kCAAnimationCubic
        anim.delegate = self
        self.searchButtonCircleView.layer.addAnimation(anim, forKey: "animate position along path")
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.searchButtonCircleView.transform = CGAffineTransformMakeScale(0.75, 0.75)
        })

    }
    
    override func animationDidStop(theAnimation: CAAnimation!, finished flag: Bool)
    {
        self.searchButtonCircleView.center = self.searchButton.center
        
        UIView.animateWithDuration(1.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.searchButton.alpha = 1.0
            self.searchButtonCircleView.alpha = 0;
        }, completion: nil)
        
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
        
        return (self.screenHeight-SECOND_IMAGE_HEIGHT)
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
        
        newYPos = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, Float(screenHeight-SECOND_IMAGE_HEIGHT), Float(YPOS_END), Float(YPOS_START)))
        
        newGradientAlpha = CGFloat(convertValue(Float(rectInSuperview.origin.y), 0, Float(screenHeight-SECOND_IMAGE_HEIGHT), Float(GRADIENT_ALPHA_END), Float(GRADIENT_ALPHA_START)))
        
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
