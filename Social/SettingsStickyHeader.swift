//
//  SettingsStickyHeader.swift
//  Social
//
//  Created by Craig Aucutt on 5/10/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//


import UIKit

class SettingsStickyHeader: UICollectionReusableView {

    @IBOutlet weak var headerLabel : UILabel?

    func setupStickyHeaderView(headerText : String) {
        headerLabel?.text = headerText
        headerLabel?.font = UIFont.mySystemFontOfSize(16)
    }
    
}
