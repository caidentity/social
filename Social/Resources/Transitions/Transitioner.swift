//
//  Transitioner.swift
//  Social
//
//  Created by Craig Aucutt on 5/15/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import UIKit


class Transitioning:NSObject, UIViewControllerAnimatedTransitioning
{
    var isPresentation:Bool
    
    /* iOS 7 has no reference to views within the 'containerView' on dismiss. This hack resolves that */
    class var tintInstance : UIViewController
    {
        struct Singleton
        {
            static let instance = UIViewController()
        }
        
        return Singleton.instance
    }
    
    required override init()
    {
        isPresentation = false
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval
    {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
         transitionContext.completeTransition(true)
    }
    
}
