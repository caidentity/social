//
//  ProfileVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/12/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import Foundation
import UIKit

class ProfileVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, ProfileHeaderLayoutDelegate {
 
    var settingsSections = [String : [String]]()
    let ProfileCellReuseIdentifier = "ProfileTableCell"
    
    let iPhone4SeriesHeight:CGFloat = 480
    let iPhone5SeriesHeight:CGFloat = 568
    let iPhone6Height:CGFloat = 667
    let iPhone6PlusHeight:CGFloat = 960
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    @IBOutlet var currentCollectionView:UICollectionView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"

        // Do any additional setup after loading the view, typically from a nib.
        currentCollectionView.alwaysBounceVertical = true;
        currentCollectionView.showsVerticalScrollIndicator = false;
        currentCollectionView.registerNib (UINib(nibName: "CollectionHeaderView", bundle: NSBundle.mainBundle()), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier:"kReusableCollectionHeaderView");
        
        // Populate Data here
        populateDataSource()
        
        // Add RightNavbar Button.
        self.addRighNavItem()        
    }

    // Add Barbutton
    func addRighNavItem() {
        
        // hide default navigation bar button item
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
    
        let buttonBack: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        buttonBack.frame = CGRectMake(0, 0, 40, 40)
        buttonBack.setImage(UIImage(named:"navbar-settings"), forState: UIControlState.Normal)
        buttonBack.addTarget(self, action: "leftNavButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
        
        self.navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: false)
        
    }
    
    // Barbutton Pressed
    func leftNavButtonClick(sender:UIButton!) {
 
        let storyboard = UIStoryboard(name: "SettingsVC", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SettingsVC") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
        let navController                           = UINavigationController(rootViewController: vc)
        navController.navigationBar.translucent     = false

        self.navigationController?.popViewControllerAnimated(true)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return settingsSections.count;
    }
   
    // Making Call here to fetch number of items in profile strings below
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let SettingsItemKeys = Array(settingsSections.keys)
        let sectionKeyAtSection = SettingsItemKeys[section]
        let SettingsItemArray = settingsSections[sectionKeyAtSection]
        return SettingsItemArray?.count ?? 0;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ProfileCellReuseIdentifier, forIndexPath: indexPath) as! ProfileTableCell
            let SettingsItemKeys = Array(settingsSections.keys)
            let sectionKeyAtSection = SettingsItemKeys[indexPath.section]
            let SettingsItemArray = settingsSections[sectionKeyAtSection]
            if let SettingsRowName = SettingsItemArray?[indexPath.row] {
                cell.setUpCellWithSettingsRowName(SettingsRowName)
            }
            // TODO: Finish seting up sublabel string
//            if let SettingsBodyName = SettingsItemArray?[indexPath.row] {
//                cell.setUpCellWithSettingsBodyName(SettingsBodyName)
//            }
        
        return cell
    }
    
    // This sets the header to only be called for first cell in collection
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableView:UICollectionReusableView?;

        reusableView = currentCollectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "kReusableCollectionHeaderView", forIndexPath: indexPath) as? UICollectionReusableView;
        
        if (settingsSections.count == 2) {
            reusableView!.hidden = true;
        }
        else {
        }

        return reusableView!;
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var size:CGSize = CGSizeZero;
        
        var flowLayout:UICollectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout;
        var sectionInset = flowLayout.sectionInset;
        
        size = CGSizeMake(currentCollectionView.frame.size.width-(sectionInset.left+sectionInset.right), 240);
        // TODO: Remove this as wont be dynamic for cells
//        if indexPath.item == 0{
//            size = CGSizeMake(currentCollectionView.frame.size.width-(sectionInset.left+sectionInset.right), 240);
//        }
//        else if (indexPath.item == 2) {
//            
//            var deviceHeight:CGFloat = UIScreen.mainScreen().bounds.size.height;
//            var cellHeight:CGFloat = 320;
//            
//            size = CGSizeMake(currentCollectionView.frame.size.width - (sectionInset.left + sectionInset.right), cellHeight);
//        }
//        
//        if (currentCollectionView.contentSize.height >= 120) {
//            currentCollectionView.contentSize = CGSizeMake(currentCollectionView.frame.size.width - (sectionInset.left + sectionInset.right), currentCollectionView.contentSize.height+size.height);
//        }
//        else{
//            currentCollectionView.contentSize = CGSizeMake(currentCollectionView.frame.size.width - (sectionInset.left + sectionInset.right), currentCollectionView.contentSize.height+size.height+120);
//        }
//        
        return size;
    }
    
    func collectionView(collectionView: UICollectionView, withCollectionViewLayout layout: UICollectionViewFlowLayout, withLayoutAttributes layoutAttributes: UICollectionViewLayoutAttributes, withProportionalChange change: CGFloat, draggingItemAtIndexPath indexPath: NSIndexPath) {
        
        if (layoutAttributes.representedElementKind == UICollectionElementKindSectionHeader) {
            
            // will add blur effect
        }
        
    }
    
    //TODO: If continued buildout remove static strings
    // MARK: Private Util methods
    private func populateDataSource() {
        var aboutme        : [String] = ["About Me"];
        var youdontknow    : [String] = ["Something You Don't Know About Me"];
        var favoritespot   : [String] = ["Favorite Spot In The City"];
        
        settingsSections =
            ["Profile" : aboutme,
             "DontKnow" : youdontknow,
             "Settings": favoritespot]
        
    }
}

