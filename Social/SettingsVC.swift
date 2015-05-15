//
//  SettingsVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/10/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//

import Foundation
import UIKit

class SettingsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var settingsSections = [String : [String]]()
    let SettingsCellReuseIdentifier = "SettingsTableCell"
    let SettingsStickyHeaderReuseIdentifier = "SettingsHeader"
    let StickyHeaderViewIdentifier = "SettingsStickyHeader"
    let stickyheaderBackgroundColor = UIColor(red: 219.0/255, green:219.0/255, blue:219.0/255, alpha:0.8)
    let SettingsStickyHeaderHeight = 40.0

    @IBOutlet weak var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register header suppplementary view
        let stickyHeaderViewNib = UINib(nibName: StickyHeaderViewIdentifier, bundle: nil)
        collectionView?.registerNib(stickyHeaderViewNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SettingsStickyHeaderReuseIdentifier)

        title = "Settings"

        // Populate sample data. This will mostly be a call to data provider which either returns back with cached datas
        // or makes a network request to get fresh data
        populateDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return settingsSections.count;
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let SettingsItemKeys = Array(settingsSections.keys)
        let sectionKeyAtSection = SettingsItemKeys[section]
        let SettingsItemArray = settingsSections[sectionKeyAtSection]
        return SettingsItemArray?.count ?? 0;
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(SettingsCellReuseIdentifier, forIndexPath: indexPath) as! SettingsTableCell
        let SettingsItemKeys = Array(settingsSections.keys)
        let sectionKeyAtSection = SettingsItemKeys[indexPath.section]
        let SettingsItemArray = settingsSections[sectionKeyAtSection]
        if let SettingsRowName = SettingsItemArray?[indexPath.row] {
            cell.setUpCellWithSettingsRowName(SettingsRowName)
        }
        return cell
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var supplementaryView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: SettingsStickyHeaderReuseIdentifier, forIndexPath: indexPath) as! SettingsStickyHeader
        let keys = Array(settingsSections.keys)
        supplementaryView.setupStickyHeaderView(keys[indexPath.section])
        return supplementaryView
    }

    // MARK: UICollectionViewDelegateFlowLayout methods
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = CGRectGetWidth(collectionView.bounds)
        return CGSizeMake(collectionView.frame.size.width, CGFloat(SettingsStickyHeaderHeight))
    }

    //TODO: Finish getting this implimented
    // Direct to Dummy Settings Input VC
    func goToSettingsInputVC()
    {
        let storyboard = UIStoryboard(name: "SettingsInputVC", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("SettingsInputVC") as! UIViewController
        
        let nav = UINavigationController(rootViewController: SettingsInputVC())
        nav.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    // MARK: Private Util methods
    private func populateDataSource() {
        var profilesettings : [String] = ["What I'm Working On", "About Me", "My Favorite Things"];
        var generalsettings : [String] = ["My Name", "My Title", "Email Address", "Password"];

        settingsSections =
            ["Profile" : profilesettings,
                "Settings": generalsettings]
        
    }
}

