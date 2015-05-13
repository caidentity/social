//
//  UIFontExtensions.swift
//  Social
//
//  Created by Craig Aucutt on 5/10/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import Foundation
import UIKit

let FontName = "ProximaNova"

extension UIFont {
    class func mySystemFontOfSize(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "\(FontName)-Regular", size: size)
        {
            return font
        }
        return UIFont.systemFontOfSize(18)
    }
    class func mylightSystemFontOfSize(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "\(FontName)-Light", size: size)
        {
            return font
        }
        return UIFont.systemFontOfSize(18)
    }
    class func mysemiboldSystemFontOfSize(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "\(FontName)-SemiBold", size: size)
        {
            return font
        }
        return UIFont.systemFontOfSize(18)
    }
    class func myboldSystemFontOfSize(size: CGFloat) -> UIFont {
        if let font = UIFont(name: "\(FontName)-Bold", size: size)
        {
            return font
        }
        return UIFont.systemFontOfSize(18)
    }
    class func mypreferredFontForTextStyle(style: String) -> UIFont {
        switch(style) {
        case UIFontTextStyleBody:
            return UIFont.systemFontOfSize(17)
        case UIFontTextStyleHeadline:
            return UIFont.boldSystemFontOfSize(17)
        case UIFontTextStyleSubheadline:
            return UIFont.systemFontOfSize(15)
        case UIFontTextStyleFootnote:
            return UIFont.systemFontOfSize(13)
        case UIFontTextStyleCaption1:
            return UIFont.systemFontOfSize(12)
        case UIFontTextStyleCaption2:
            return UIFont.systemFontOfSize(11)
        default:
            return UIFont.systemFontOfSize(17)
        }
    }
}
