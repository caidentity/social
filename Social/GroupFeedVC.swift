//
//  GroupFeedVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/16/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import Foundation
import UIKit

class GroupFeedVC: UITableViewController
{
    let kCellIdentifier = "CellIdentifier"
    
    var model = Model()
    
    var expandedPaths = [NSIndexPath]()
    
    override init(style: UITableViewStyle)
    {
        super.init(style: style)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Engineering Feed"
        
        tableView.registerNib(UINib(nibName: "FeedTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: kCellIdentifier)
        
        self.tableView.contentInset = UIEdgeInsets(top: 10, left: tableView.contentInset.bottom,
            bottom: 15, right: tableView.contentInset.right)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200.0
        
        model.appendData(20)
        tableView.reloadData()
        
        // Add RightNav Button.
        self.addRightNavItem()
        
        // Add LeftNav Button.
        self.addBackNavItem()
    }
    
    // Pops back button
    func popToRoot(sender:UIBarButtonItem){
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    // Add Back Button
    func addBackNavItem() {
        navigationController!.setNavigationBarHidden(false, animated:true)
        var myBackButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        myBackButton.addTarget(self, action: "popToRoot:", forControlEvents: UIControlEvents.TouchUpInside)
        myBackButton.setImage(UIImage(named:"navbar-back"), forState: UIControlState.Normal)
        myBackButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        myBackButton.sizeToFit()
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
    }
    
    // Add Barbutton
    func addRightNavItem()
    {
        
        // hide default navigation bar button item
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        
        let buttonPost: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        buttonPost.frame = CGRectMake(0, 0, 20, 40)
        buttonPost.setImage(UIImage(named:"navbar-post"), forState: UIControlState.Normal)
        buttonPost.addTarget(self, action: "rightNavButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonPost)
        
        self.navigationItem.setRightBarButtonItem(leftBarButtonItem, animated: false)
        
    }
    
    // Right Barbutton Pressed
    func rightNavButtonClick(sender:UIButton!)
    {
        
        let navController = UIStoryboard(name: "SettingsVC", bundle: nil).instantiateInitialViewController() as! UIViewController
        
        navController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        presentViewController(navController, animated: true, completion: nil)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    // This function will be called when the Dynamic Type user setting changes (from the system Settings app)
    func contentSizeCategoryChanged(notification: NSNotification)
    {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return model.data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! FeedTableViewCell
        
        cell.configure(model.data[indexPath.row])
        //cell.controller = self
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == model.data.count - 1 {
            let newDataCount = 20
            let lastIndex = indexPath.row
            var indexPaths = [NSIndexPath]()
            
            model.appendData(newDataCount)
            
            for idx in 1...newDataCount {
                indexPaths.append(NSIndexPath(forRow: lastIndex + idx, inSection: indexPath.section))
            }
            //tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic) // crashing the app
            tableView.reloadData()
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //if let FeedDetailVC : FeedDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("FeedDetailVC") as? FeedDetailVC {
        
        //load detail view controller
        //self.presentViewController(FeedDetailVC, animated: true, completion: nil)
    }
}


/*override func tableView(tableView: UITableView!, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
{
// If you are just returning a constant value from this method, you should instead just set the table view's
// estimatedRowHeight property (in viewDidLoad or similar), which is even faster as the table view won't
// have to call this method for every row in the table view.
//
// Only implement this method if you have row heights that vary by extreme amounts and you notice the scroll indicator
// "jumping" as you scroll the table view when using a constant estimatedRowHeight. If you do implement this method,
// be sure to do as little work as possible to get a reasonably-accurate estimate.

return 44.0
}*/


//    func reloadCell(cell: UITableViewCell) {
//        if let indexPath = tableView.indexPathForCell(cell) {
//            if let index = find(expandedPaths, indexPath) {
//                expandedPaths.removeAtIndex(index)
//            }
//            else {
//                expandedPaths.append(indexPath)
//            }
//            //tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic) // does a not nice row blinking
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
//        else {
//            println("not found")
//        }
//    }

