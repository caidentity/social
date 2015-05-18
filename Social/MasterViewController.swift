//
//  MasterViewController.swift
//  Social
//
//  Created by Craig Aucutt on 5/9/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//

import UIKit

enum TabBarItemIndex:Int
{
    case FeedIndex          = 0
    case GroupIndex         = 1
    case ProfileIndex       = 2
    
    static let allValues    = [FeedIndex, GroupIndex, ProfileIndex]
    static let nameValues   = ["Feed", "Groups", "Profile"]
}

enum UserNuxSeenStatus:String
{
    case UserHasSeen = "userHasSeen"
}

class MasterViewController: UITabBarController, UITabBarDelegate
{
    
    //MARK: - Inherited Methods
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // use MasterVC as the delegate for navigation
        //NavigationHandler.sharedInstance.delegate = self
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        // setup appearance
        self.view.backgroundColor = UIColor.whiteColor()
        
        // setup tab bar appearance
        self.tabBar.translucent = false
        self.resetRootViewControllers()
        
    }
    
    
    //MARK: - Instance Methods
    /// Convenience method to reset tabbar's root viewcontrollers
    func resetRootViewControllers()
    {
        // setup the tabs
        self.setupRootViewControllersAndTabs(forTitles: [
            NSLocalizedString("Feed", comment: "Feed tab bar item"),
            NSLocalizedString("Groups", comment: "Group tab bar item"),
            NSLocalizedString("Profile", comment: "Profile tab bar item")])
    }
    
    func setupRootViewControllersAndTabs(let forTitles titles:[String])
    {
        var viewControllers: Array<UIViewController> = Array()
        
        let tabBarItemIndices = TabBarItemIndex.allValues
        for(var i: Int = 0; i < tabBarItemIndices.count; ++i)
        {
            let featureName:String      = TabBarItemIndex.nameValues[i]
            let imageString:String      = featureName.lowercaseString
            
            let inactiveClassAct        = UIImage(named: "\(imageString)-inactive")
            let activeClassAct          = UIImage(named: "\(imageString)-active")
            let titleClassAct           = titles[i]
            var item:UITabBarItem       = UITabBarItem(title:titleClassAct, image: inactiveClassAct, selectedImage: activeClassAct)
            item.tag                    = i
            item.setTitlePositionAdjustment(UIOffsetMake(0, -4))
            
            if let tabBarItemIdx = TabBarItemIndex(rawValue: i)
            {
                if let vc: UIViewController = self._viewControllerForIndex(tabBarItemIdx)
                {
                    vc.tabBarItem = item
                    viewControllers.append(vc)
                }
            }
        }
        self.setViewControllers(viewControllers, animated: false)
    }
    
    override func supportedInterfaceOrientations() -> Int
    {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
}

//Setup Navigation
private extension MasterViewController
{
    func _loadFeatureViewController(let forFeatureName featureName:String) -> UIViewController
    {
        // load the vc from the story board
        let vc:UIViewController = UIStoryboard(name: featureName.capitalizedString, bundle: nil).instantiateInitialViewController() as! UIViewController
        
        // setup navigation controller
        let navController                           = UINavigationController(rootViewController: vc)
        navController.navigationBar.translucent     = false
        
        // Add Rightbarbutton Item
        let navpost = UIImage(named: "navbar-settings")
        let settingsButton = UIBarButtonItem(image: navpost, style: UIBarButtonItemStyle.Plain, target: self, action: "openSettings:")
        vc.navigationItem.leftBarButtonItem = settingsButton
       
        return navController
    }
    
    func _viewControllerForIndex(idx: TabBarItemIndex) -> UIViewController?
    {
        var controller:UIViewController? = nil
        
        // determine which controller to select
        switch(idx)
        {
            
        case .FeedIndex:
            // create the timeline
            //let TableViewController = self._loadFeatureViewController(forFeatureName: "TableViewController")
            //controller = TableViewController
            
            let storyboard = UIStoryboard(name: "TableViewController", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("TableViewController") as! UITableViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
            let navController                           = UINavigationController(rootViewController: vc)
            navController.navigationBar.translucent     = false
            
            return navController

        case .GroupIndex:
            // create announcements
            let storyboard = UIStoryboard(name: "GroupListVC", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("GroupListVC") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
            let navController                           = UINavigationController(rootViewController: vc)
            navController.navigationBar.translucent     = false
            
            return navController

        case .ProfileIndex:
            // create announcements
            let storyboard = UIStoryboard(name: "ProfileVC", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("ProfileVC") as! UIViewController
            self.presentViewController(vc, animated: true, completion: nil)
            
            let navController                           = UINavigationController(rootViewController: vc)
            
            return navController
        }
    
    }
    // finally we begin loading the information for the main view of the app
    func _loadMainView()
    {
        // ensure the main VCs are setup correctly
        self.resetRootViewControllers()
    }
}

// Open Nav RightbarButtonItems
func openSettings(sender: UIBarButtonItem?)
{
    println("Posting Soon Here")
}


//MARK: - UITabBarDelegate
extension MasterViewController : UITabBarControllerDelegate
{
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!)
    {
        if let barItems = tabBar.items as? [UITabBarItem]
        {
            // Determine the index of the item which was selected
            if let itemIndex = find(barItems, item)
            {
                if let tbIndex = TabBarItemIndex(rawValue: itemIndex)
                {
                    switch(tbIndex)
                    {
                    case .FeedIndex:
                        break
                    case .GroupIndex:
                        break
                    case .ProfileIndex:
                        break
                    }
                }
            }
        }
    }
}

extension MasterViewController : UINavigationControllerDelegate
{
    func navigationControllerSupportedInterfaceOrientations(navigationController: UINavigationController) -> Int
    {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
}
