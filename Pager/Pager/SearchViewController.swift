//
//  SearchViewController.swift
//  Pager
//
//  Created by Vignesh Ramesh on 6/29/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var autocompleteTableView: UITableView!
    var autocompleteSuggestions = [String]()
    
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var findButtonBottomContraint: NSLayoutConstraint!
    
    var searchString: String!
    
    var initialBottom: CGFloat!
    let offset: CGFloat = 20


    override func viewDidLoad() {
        super.viewDidLoad()

        autocompleteTableView.delegate = self
        autocompleteTableView.dataSource = self
        autocompleteTableView.scrollEnabled = true
        autocompleteTableView.hidden = true
        
        searchTextField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        //set the initial y position of findButton
        initialBottom = findButtonBottomContraint.constant

    }
    
    override func viewDidLayoutSubviews() {
        let screenSize = UIScreen.mainScreen().bounds
        self.view.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
    }
    
    override func viewWillAppear(animated: Bool) {
        showMainTabBar()
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        autocompleteTableView.hidden = false
        var substring = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        searchAutocompleteEntriesWithSubstring(substring)
        return true     // not sure about this - could be false
    }
    
    func searchAutocompleteEntriesWithSubstring(substring: String)
    {
        autocompleteSuggestions.removeAll(keepCapacity: false)
        
        for curString in searchStrings
        {
            var myString:NSString! = curString as NSString
            
            var substringRange :NSRange! = myString.rangeOfString(substring)
            
            if (substringRange.location  == 0)
            {
                autocompleteSuggestions.append(curString)
            }
        }
        
        if(autocompleteSuggestions.count > 0) {
            autocompleteTableView.hidden = false
            autocompleteTableView.reloadData()
        }
        else {
            autocompleteTableView.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocompleteSuggestions.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : AutocompleteTableViewCell = tableView.dequeueReusableCellWithIdentifier("autocompleteTableViewCell", forIndexPath: indexPath) as! AutocompleteTableViewCell
        let index = indexPath.row as Int
        
        cell.autocompleteSuggestionLabel.text = autocompleteSuggestions[index]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell : AutocompleteTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! AutocompleteTableViewCell
        searchTextField.text = selectedCell.autocompleteSuggestionLabel.text
        autocompleteTableView.hidden = true
        
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        var animationCurve = curveValue.integerValue
        
        let parentVC = self.parentViewController as! SearchNavigationController
        let tabBarChildVC = parentVC.parentViewController as! TabBarSearchViewController
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
            
            self.findButtonBottomContraint.constant = kbSize.height + self.offset
            self.findButton.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        var animationCurve = curveValue.integerValue
                
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
            self.findButtonBottomContraint.constant = self.initialBottom
            self.findButton.layoutIfNeeded()
            
            }, completion: nil)
    }

    func showMainTabBar() {
        let parentVC = self.parentViewController as! SearchNavigationController
        let tabBarChildVC = parentVC.parentViewController as! TabBarSearchViewController
        setTabBarVisible(true, true, true, tabBarChildVC)
    }
    
    func hideMainTabBar() {
        let parentVC = self.parentViewController as! SearchNavigationController
        let tabBarChildVC = parentVC.parentViewController as! TabBarSearchViewController
        setTabBarVisible(false, true, false, tabBarChildVC)
    }

    @IBAction func nextBtnDidPress(sender: AnyObject) {
        
        self.searchString = searchTextField.text!
        hideMainTabBar()

        //transition to TellMeMoreViewController
        var storyboard = UIStoryboard(name: "Chat", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("tellMeMoreVC") as! TellMeMoreViewController
        //        controller.tellMeMoreLabelTitle.text = textString
        self.navigationController?.pushViewController(controller, animated: true)
        
        resetSearchView()

    }
    
    func resetSearchView() {
        searchTextField.text = ""
        autocompleteSuggestions.removeAll(keepCapacity: false)
    }


}
