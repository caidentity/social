//
//  FeedDetailCell.swift
//  Social
//
//  Created by Craig Aucutt on 5/9/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//

import UIKit

class FeedDetailCell: TableViewController
{
    @IBOutlet weak var teacherProfileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var theAnnouncementLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lastVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomOutlineConstraint: NSLayoutConstraint!
    
    let bottomOutlineOffset: CGFloat = -8
    
    override func awakeFromNib()
    {
        
        self.teacherProfileImageView.layer.cornerRadius = 3.0
        self.teacherProfileImageView.layer.masksToBounds = true
        self.teacherProfileImageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.teacherProfileImageView.layer.borderWidth = 0.5
        self.teacherProfileImageView.backgroundColor = UIColor.lightGrayColor() // for temp image
    }
   }
