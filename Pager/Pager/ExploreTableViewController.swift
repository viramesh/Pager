//
//  ExploreTableViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 6/29/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class ExploreTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //pageviewcontroller values
    var pageIndex: Int?
    var showTableHeader:Bool = true
    var tableHeaderOffset:Int = 0
    
    //UI Components
    @IBOutlet var exploreView: UIView!
    @IBOutlet weak var exploreTableView: UITableView!
    var exploreTableViewCell: ExploreTableViewCell!
    var exploreTableViewHeader: ExploreTableViewHeader!
    var exploreImages = [String]()
    var exploreImageLabels = [String]()
    
    //Table cell properties
    let ROUNDED_CORNER:CGFloat = 2
    
    //screensize
    var screenSize: CGRect = CGRectZero
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    
    //for parallax-ing the images
    var topIndexRow:Int = 0
    let TOP_MARGIN:CGFloat = 0
    let YPOS_START:CGFloat = -120
    let YPOS_END:CGFloat = -140
    var newYPos:CGFloat = -140
    let GRADIENT_ALPHA_START:CGFloat = 0.3
    let GRADIENT_ALPHA_END:CGFloat = 0
    var newGradientAlpha:CGFloat = 0
    
    
    let TABLE_CELL_MAX_HEIGHT_PERCENTAGE:CGFloat = 0.4
    let TABLE_CELL_MIN_HEIGHT_PERCENTAGE:CGFloat = 0.3
    var TABLE_CELL_MAX_HEIGHT:CGFloat! // this value is set in viewdidload
    var TABLE_CELL_MIN_HEIGHT:CGFloat! // this value is set in viewdidload
    var newHeight: CGFloat! // this value is set in viewdidload

    
    //for custom transition into this VC
    var isPresenting: Bool = true
    
    //for the prompt label
    let TABLE_HEADER_HEIGHT:CGFloat = 120
    
    //for hiding tab bar in mainVC
    //var parentVC:TabBarExploreViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize screensize variables
        screenSize = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        screenWidth = screenSize.width
        
        //setup table
        exploreTableView.dataSource = self
        exploreTableView.delegate = self
        exploreTableView.bounces = true

        TABLE_CELL_MAX_HEIGHT = screenHeight * TABLE_CELL_MAX_HEIGHT_PERCENTAGE
        TABLE_CELL_MIN_HEIGHT = screenHeight * TABLE_CELL_MIN_HEIGHT_PERCENTAGE
        newHeight = CGFloat(convertValue(Float(TABLE_HEADER_HEIGHT), Float(TOP_MARGIN), Float(TOP_MARGIN + TABLE_CELL_MAX_HEIGHT), Float(TABLE_CELL_MAX_HEIGHT), Float(TABLE_CELL_MIN_HEIGHT)))
        
        if(showTableHeader) {
            tableHeaderOffset = 1
            topIndexRow = 1
        }
        
        //parentVC = self.parentViewController as! TabBarExploreViewController
        
    }

    override func viewDidLayoutSubviews() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /******************
    //  TABLE VIEW
    //  This part contains code to populate the table view
    *******************/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return exploreImages.count+tableHeaderOffset
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //first load the header prompt
        if(indexPath.row == 0 && showTableHeader) {
            exploreTableViewHeader = tableView.dequeueReusableCellWithIdentifier("ExploreTableViewHeaderid") as! ExploreTableViewHeader
            exploreTableViewHeader.backgroundColor = UIColor.clearColor()
            
            return exploreTableViewHeader
        }
        
        //then load all other cells
        else {
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
            exploreTableViewCell.exploreImage.image = UIImage(named: exploreImages[indexPath.row-tableHeaderOffset])
            exploreTableViewCell.exploreImage.contentMode = UIViewContentMode.ScaleAspectFill
            exploreTableViewCell.exploreImageContainer.layer.cornerRadius = ROUNDED_CORNER
            exploreTableViewCell.exploreImageContainer.addSubview(exploreTableViewCell.exploreImage)
            exploreTableViewCell.exploreImageOverlayGradient.alpha = gradientAlpha
            exploreTableViewCell.exploreImageOverlayView.layer.cornerRadius = ROUNDED_CORNER
            exploreTableViewCell.exploreImageOverlayLabel.text = exploreImageLabels[indexPath.row-tableHeaderOffset] as String
            exploreTableViewCell.backgroundColor = UIColor.clearColor()
            
            return exploreTableViewCell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var heightForRow:CGFloat = self.TABLE_CELL_MIN_HEIGHT
        
        if(indexPath.row == 0 && showTableHeader) {
            heightForRow = self.TABLE_HEADER_HEIGHT
        }
        else if(indexPath.row < topIndexRow) {
            heightForRow = self.TABLE_CELL_MAX_HEIGHT
        }
        else if(indexPath.row == topIndexRow) {
            heightForRow = self.newHeight
        }
        
        return heightForRow
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        println("table scrolled")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        //adjust table rows
        let visibleImages = exploreTableView.indexPathsForVisibleRows() as! [NSIndexPath]
        if visibleImages.count <= 1 {
            exploreTableView.reloadData()
            return
        }
        
        var second_one:Int = 1
        if(visibleImages[0] == 0) { second_one = 2 }
        
        let rectInTableView: CGRect = exploreTableView.rectForRowAtIndexPath(visibleImages[second_one])
        let rectInSuperview: CGRect = exploreTableView.convertRect(rectInTableView, toView: exploreTableView.superview)
    
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenHeight = screenSize.height
        
        newYPos = CGFloat(convertValue(Float(rectInSuperview.origin.y), Float(TOP_MARGIN), Float(TOP_MARGIN + TABLE_CELL_MAX_HEIGHT), Float(YPOS_END), Float(YPOS_START)))
        
        newGradientAlpha = CGFloat(convertValue(Float(rectInSuperview.origin.y), Float(TOP_MARGIN), Float(TOP_MARGIN + TABLE_CELL_MAX_HEIGHT), Float(GRADIENT_ALPHA_END), Float(GRADIENT_ALPHA_START)))
        
        newHeight = CGFloat(convertValue(Float(rectInSuperview.origin.y), Float(TOP_MARGIN), Float(TOP_MARGIN + TABLE_CELL_MAX_HEIGHT), Float(TABLE_CELL_MAX_HEIGHT), Float(TABLE_CELL_MIN_HEIGHT)))
        
        topIndexRow = visibleImages[second_one].row
        
        exploreTableView.reloadData()
        
        var velocity:CGPoint = scrollView.panGestureRecognizer.velocityInView(scrollView)
        if(velocity.y < 0) {
            //setTabBarVisible(false, true, true, parentVC)
        }
        else if(velocity.y > 0) {
            //setTabBarVisible(true, true, true, parentVC)
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
/*
        var visibleCells = exploreTableView.indexPathsForVisibleRows() as! [NSIndexPath]
        
        if(velocity.y <= 0 || visibleCells.count <= 1) {
            var rectInTableView: CGRect = exploreTableView.rectForRowAtIndexPath(visibleCells[0])
            targetContentOffset.memory.y = rectInTableView.origin.y
            
        }
        else {
            var rectInTableView: CGRect = exploreTableView.rectForRowAtIndexPath(visibleCells[1])
            targetContentOffset.memory.y = rectInTableView.origin.y
            
        }
*/
        
    }
}
