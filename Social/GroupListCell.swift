//
//  GroupListCell.swift
//  Social
//
//  Created by Craig Aucutt on 5/16/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import Foundation
import UIKit

class GroupListCell: UICollectionViewCell {
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    
    let kLabelVerticalInsets: CGFloat = 8.0
    let kLabelHorizontalInsets: CGFloat = 8.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Need set autoresizingMask to let contentView always occupy this view's bounds, key for iOS7
        self.contentView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        self.layer.masksToBounds = true
        
        groupLabel.textColor = UIColor.TWGray7()
        groupLabel.font = UIFont.mySystemFontOfSize(17)

        membersLabel.textColor = UIColor.TWGray5()
        membersLabel.font = UIFont.mySystemFontOfSize(14)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Set what preferredMaxLayoutWidth you want
        groupLabel.preferredMaxLayoutWidth = self.bounds.width - 2 * kLabelHorizontalInsets
    }
}
