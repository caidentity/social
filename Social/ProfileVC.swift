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
        
        // Do any additional setup after loading the view, typically from a nib.
        self.addRighNavItem()
        
    }

    // Add Barbutton
    func addRighNavItem()
    {
        
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
    func leftNavButtonClick(sender:UIButton!)
    {
 
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
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var collectionViewCell:UICollectionViewCell?;
        
        if indexPath.row == 0 {
            collectionViewCell = currentCollectionView.dequeueReusableCellWithReuseIdentifier("kReusableCollectionViewCell1", forIndexPath: indexPath) as? UICollectionViewCell;
        }
        else if (indexPath.row == 1){
            collectionViewCell = currentCollectionView.dequeueReusableCellWithReuseIdentifier("kReusableMapCollectionViewCell", forIndexPath: indexPath) as? UICollectionViewCell;
        }
        
        return collectionViewCell!;
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableView:UICollectionReusableView?;
        
        reusableView = currentCollectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "kReusableCollectionHeaderView", forIndexPath: indexPath) as? UICollectionReusableView;
        
        return reusableView!;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var size:CGSize = CGSizeZero;
        
        var flowLayout:UICollectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout;
        var sectionInset = flowLayout.sectionInset;
        
        if indexPath.item == 0{
            size = CGSizeMake(currentCollectionView.frame.size.width-(sectionInset.left+sectionInset.right), 40);
        }
        else if (indexPath.item == 1) {
            
            var deviceHeight:CGFloat = UIScreen.mainScreen().bounds.size.height;
            var cellHeight:CGFloat = 320;
            
            switch (deviceHeight) {
            case iPhone4SeriesHeight:
                cellHeight = 320;
                break;
                
            case iPhone5SeriesHeight:
                cellHeight = 410;
                break;
                
            case iPhone6Height:
                cellHeight = 560;
                break;
                
            case iPhone6PlusHeight:
                cellHeight = 600;
                break;
                
            default:
                break;
            }
            
            size = CGSizeMake(currentCollectionView.frame.size.width - (sectionInset.left + sectionInset.right), cellHeight);
        }
        
        if (currentCollectionView.contentSize.height >= 120) {
            currentCollectionView.contentSize = CGSizeMake(currentCollectionView.frame.size.width - (sectionInset.left + sectionInset.right), currentCollectionView.contentSize.height+size.height);
        }
        else{
            currentCollectionView.contentSize = CGSizeMake(currentCollectionView.frame.size.width - (sectionInset.left + sectionInset.right), currentCollectionView.contentSize.height+size.height+120);
        }
        
        return size;
    }
    
    func collectionView(collectionView: UICollectionView, withCollectionViewLayout layout: UICollectionViewFlowLayout, withLayoutAttributes layoutAttributes: UICollectionViewLayoutAttributes, withProportionalChange change: CGFloat, draggingItemAtIndexPath indexPath: NSIndexPath) {
        
        if (layoutAttributes.representedElementKind == UICollectionElementKindSectionHeader) {
            
            // will add blur effect
        }
        
    }
    
}

