//
//  ZoomPresentationController.swift
//  Social
//
//  Created by Craig Aucutt on 5/15/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import UIKit

class ZoomPresentationController: UIPresentationController
{
    var tintView:UIView
    
    override init(presentedViewController: UIViewController!, presentingViewController: UIViewController!)
    {
        self.tintView = UIView()
        self.tintView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)

        super.init()
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect
    {
        let containerBounds:CGRect = self.containerView.bounds
        
        return containerBounds;
    }
    
    override func presentationTransitionWillBegin()
    {
        super.presentationTransitionWillBegin()
        
        self.addViewsToDimmingView()
        
        self.tintView.alpha = 0.0
        
        self.presentedViewController.transitionCoordinator()?.animateAlongsideTransition({(UIViewControllerTransitionCoordinatorContext) -> Void in
            self.tintView.alpha = 1.0
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                //nothing to do
        })
    }
    
    override func containerViewWillLayoutSubviews()
    {
        self.tintView.frame = self.containerView.bounds
        self.presentedView().frame = self.frameOfPresentedViewInContainerView()
    }
    
    override func dismissalTransitionWillBegin()
    {
        super.dismissalTransitionWillBegin()
        
        self.presentedViewController.transitionCoordinator()?.animateAlongsideTransition({(UIViewControllerTransitionCoordinatorContext) -> Void in
            self.tintView.alpha = 0.0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //
        })
    }
    
    //TODO: rename after porting
    func addViewsToDimmingView()
    {
        self.containerView.addSubview(self.tintView)
    }
    
    
}
