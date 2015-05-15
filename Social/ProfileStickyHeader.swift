//
//  ProfileStickyHeader.swift
//  Social
//
//  Created by Craig Aucutt on 5/10/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//


import UIKit

class ProfileStickyHeader: UICollectionReusableView {

    @IBOutlet weak var profileheaderLabel : UILabel?

    func setupStickyHeaderView(headerText : String) {
        profileheaderLabel?.text = headerText
        profileheaderLabel?.font = UIFont.mySystemFontOfSize(16)
    }
    
}
