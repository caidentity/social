//
//  GroupListVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/16/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import Foundation
import UIKit

let reuseIdentifier = "GroupListCell"

class GroupListVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let kHorizontalInsets: CGFloat = 10.0
    let kVerticalInsets: CGFloat = 10.0
    let titles = [
        "Business",
        "Engineering",
        "Operations",
        "Marketing",
        "Community",
        "Design"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Groups"

        // Add LeftNav Button.
        self.addLeftNavItem()
    }
    
    // Add Barbutton
    func addLeftNavItem()
    {
        
        // hide default navigation bar button item
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        
        let buttonBack: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        buttonBack.frame = CGRectMake(0, 0, 20, 40)
        buttonBack.setImage(UIImage(named:"navbar-settings"), forState: UIControlState.Normal)
        buttonBack.addTarget(self, action: "leftNavButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
        
        self.navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: false)
    }
    
    // Left Barbutton Pressed
    func leftNavButtonClick(sender:UIButton!)
    {
        
        let navController = UIStoryboard(name: "SettingsVC", bundle: nil).instantiateInitialViewController() as! UIViewController
        
        navController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        presentViewController(navController, animated: true, completion: nil)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 6
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GroupListCell
        cell.groupLabel.text = self.titles[indexPath.row % 5]
        let curr = indexPath.row % 6  + 1
        let imgName = "groups-\(curr)"
        cell.groupImage.image = UIImage(named: imgName)
        
        return cell
    }
    
    // Direct to group feed
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){

        let storyboard = UIStoryboard(name: "GroupFeedVC", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("GroupFeedVC") as! UITableViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    // TODO: This can be optimized a bit, currently a little hacky
    //Sets dynamic width for the cell
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        var size : CGSize = CGSize(width: self.view.bounds.size.width / 2.22, height: 225)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(kVerticalInsets, kHorizontalInsets, kVerticalInsets, kHorizontalInsets)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kHorizontalInsets
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kVerticalInsets
    }
}
//MARK: - UIViewControllerTransitioningDelegate
extension GroupListVC : UIViewControllerTransitioningDelegate
{
    func animationControllerForPresentedController(presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        var animationController:Transitioning = PushbackTransitioning()
        
        animationController.isPresentation = true
        return animationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        var animationController:Transitioning = PushbackTransitioning()
        
        animationController.isPresentation = false
        
        return animationController
    }
}
