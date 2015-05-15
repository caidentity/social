//
//  ProfileTableCell.swift
//  Social
//
//  Created by Craig Aucutt on 5/10/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//


import UIKit

class ProfileTableCell: UICollectionViewCell {

    @IBOutlet weak var ProfileRowNameLabel : UILabel?
    @IBOutlet weak var ProfileRowBodyLabel : UILabel?
    
    func setUpCellWithSettingsRowName(SettingsRowName: String) {
        ProfileRowNameLabel?.text = SettingsRowName
        ProfileRowNameLabel?.font = UIFont.mySystemFontOfSize(20)

    }
    func setUpCellWithSettingsRowBody(SettingsRowBody: String) {
        ProfileRowBodyLabel?.text = SettingsRowBody
        ProfileRowBodyLabel?.font = UIFont.mySystemFontOfSize(16)
        
    }
}
