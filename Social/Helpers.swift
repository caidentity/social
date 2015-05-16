//
//  Helpers.swift
//  Social
//
//  Created by Craig Aucutt on 5/15/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import Foundation
import UIKit

func heightOfLabel(withString: String, ofSize: CGFloat, inWidth: CGFloat) -> CGFloat {
    //let labelFont = UIFont.systemFontOfSize(ofSize)
    let labelFont = UIFont(name: "HelveticaNeue-Light", size: ofSize)!
    let labelSize = (withString as NSString).boundingRectWithSize(CGSizeMake(inWidth, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: labelFont], context: nil)
    return ceil(labelSize.height)
}