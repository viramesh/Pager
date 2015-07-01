//
//  ExploreViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 6/29/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var exploreTableView: UITableView!
    var exploreTableViewCell: ExploreTableViewCell!
    var exploreImages = [String]()
    
    //for parallax-ing the images
    var topIndexRow:Int = 0
    var newYPos:CGFloat = 0
    let YPOS_START:CGFloat = -80
    let YPOS_END:CGFloat = 0
    let SECOND_IMAGE_HEIGHT:CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exploreTableView.dataSource = self
        exploreTableView.delegate = self
        
        exploreImages = ["crack", "holes", "leak", "locks", "plumbing", "wallpainting"]
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return exploreImages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        exploreTableViewCell = tableView.dequeueReusableCellWithIdentifier("ExploreTableViewCellid") as! ExploreTableViewCell
        
        var yPos: CGFloat = 0
        
        if(exploreTableViewCell.exploreImage == nil) {
            exploreTableViewCell.exploreImage = UIImageView()
        }
        
        if(indexPath.row < topIndexRow) {
            yPos = YPOS_END;
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            var exploreImageFrame: CGRect = CGRectMake(0, yPos, screenSize.width, screenSize.height)
            exploreTableViewCell.exploreImage.frame = exploreImageFrame

        }
        else if(indexPath.row == topIndexRow) {
            yPos = newYPos;
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            var exploreImageFrame: CGRect = CGRectMake(0, yPos, screenSize.width, screenSize.height)
            exploreTableViewCell.exploreImage.frame = exploreImageFrame
        }
        else {
            yPos = YPOS_START;
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            var exploreImageFrame: CGRect = CGRectMake(0, yPos, screenSize.width, screenSize.height)
            exploreTableViewCell.exploreImage.frame = exploreImageFrame

        }
        
        exploreTableViewCell.exploreImage.image = UIImage(named: exploreImages[indexPath.row])
        exploreTableViewCell.exploreImage.contentMode = UIViewContentMode.ScaleAspectFill
        
        exploreTableViewCell.exploreImageContainer.addSubview(exploreTableViewCell.exploreImage)
        
        return exploreTableViewCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenHeight = screenSize.height
        return (screenHeight-SECOND_IMAGE_HEIGHT)
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
