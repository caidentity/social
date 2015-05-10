//
//  UIColorExtension.swift
//  Social
//
//  Created by Craig Aucutt on 5/9/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    /** "#FFFFFF" / "0xFFFFFF" / "0XFFFFFF" -> UIColor() */
    class func colorWithHexString(let hex: NSString, let colorAlpha: CGFloat = 1.0) -> UIColor
    {
        let defaultVoidColor = UIColor.clearColor()
        
        // hex string format can be #FFFFFF, 0xFFFFFF, 0XFFFFFF, or FFFFFF, so just grab the last 6 chars.
        let hexWithNoSpaces: NSString = hex.stringByReplacingOccurrencesOfString(" ", withString: "")
        let parsedHex: NSString = hexWithNoSpaces.substringFromIndex(max(hexWithNoSpaces.length - 6, 0))
        
        // parsedHex should be exactly 6 chars at this point.
        if parsedHex.length < 6
        { return defaultVoidColor }
        
        //TODO: Need to figure out how efficient NSScanner is for real-time allocation.
        var rgbValue: UInt32 = 0
        let scanner = NSScanner(string: parsedHex as String)
        scanner.scanLocation = 0
        scanner.scanHexInt(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)
        let green = CGFloat((rgbValue & 0x00FF00) >> 8)
        let blue = CGFloat((rgbValue & 0x0000FF) >> 0)
        
        let color = UIColor(red: red/255.0,
            green: green/255.0,
            blue: blue/255.0,
            alpha: colorAlpha)
        return color
    }

    //Gray Scale 1
    class func TWGray1() -> UIColor
    {
        return UIColor(red: 246/255.0, green: 250/255.0, blue: 253/255.0, alpha: 1.0)
    }
    //Gray Scale 2
    class func TWGray2() -> UIColor
    {
        return UIColor(red: 243/255.0, green: 247/255.0, blue: 249/255.0, alpha: 1.0)
    }
    //Gray Scale 3
    class func TWGray3() -> UIColor
    {
        return UIColor(red: 230/255.0, green: 235/255.0, blue: 238/255.0, alpha: 1.0)
    }
    //Gray Scale 4
    class func TWGray4() -> UIColor
    {
        return UIColor(red: 149/255.0, green: 160/255.0, blue: 166/255.0, alpha: 1.0)
    }
    //Gray Scale 5
    class func TWGray5() -> UIColor
    {
        return UIColor(red: 106/255.0, green: 116/255.0, blue: 122/255.0, alpha: 1.0)
    }
    //Gray Scale 6
    class func TWGray6() -> UIColor
    {
        return UIColor(red: 72/255.0, green: 83/255.0, blue: 89/255.0, alpha: 1.0)
    }
    //Gray Scale 5
    class func TWGray7() -> UIColor
    {
        return UIColor(red: 51/255.0, green: 65/255.0, blue: 72/255.0, alpha: 1.0)
    }
    
    // Here is the color pallete
    //TWPrimaryRed
    class func TWRed() -> UIColor
    {
        return UIColor(red: 200/255.0, green: 52/255.0, blue: 66/255.0, alpha: 1.0)
    }
}