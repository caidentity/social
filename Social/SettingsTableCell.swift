//
//  SettingsTableCell.swift
//  Social
//
//  Created by Craig Aucutt on 5/10/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//


import UIKit

class SettingsTableCell: UICollectionViewCell {

    @IBOutlet weak var SettingsRowNameLabel : UILabel?
    
    func setUpCellWithSettingsRowName(SettingsRowName: String) {
        SettingsRowNameLabel?.text = SettingsRowName
        SettingsRowNameLabel?.font = UIFont.mySystemFontOfSize(16)

    }
}
