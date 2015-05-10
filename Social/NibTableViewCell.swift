//
//  NibTableViewCell.swift
//  Social
//
//  Created by Craig Aucutt on 5/9/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//

import UIKit

class NibTableViewCell: UITableViewCell
{
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
        
    var controller: TableViewController?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.appearence()
    }
    func appearence() {
        // Title
        titleLabel.textColor = UIColor.TWGray6()
        dateLabel.textColor = UIColor.TWGray4()
        bodyTextView.textColor = UIColor.TWGray7()
        
        //userAvatar
        self.userAvatar.layer.cornerRadius = 4.0
        self.userAvatar.layer.masksToBounds = true
        self.userAvatar.layer.borderColor = UIColor.TWGray2().CGColor
        self.userAvatar.layer.borderWidth = 0.5
        self.userAvatar.backgroundColor = UIColor.TWGray2() // for temp image

    }

    func configure(cellData: Model.CellData) {
        titleLabel.text = cellData.title
        
        bodyTextView.text = cellData.message
        
        headerHeightConstraint.constant = cellData.hasHeader ? 52 : 52
    }
    
}
