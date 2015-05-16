//
//  ZoomTransitioner.swift
//  Social
//
//  Created by Craig Aucutt on 5/15/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import UIKit

class ZoomTransitioningDelegate:NSObject, UIViewControllerTransitioningDelegate
{
    func presentationControllerForPresentedViewController(presented: UIViewController,
        presentingViewController presenting: UIViewController!,
        sourceViewController source: UIViewController) -> UIPresentationController?
    {
        return ZoomPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    func animationController() -> ZoomTransitioning
    {
        var animationController:ZoomTransitioning = ZoomTransitioning()
        return animationController
    }
    
    func animationControllerForPresentedController(presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        var animationController:ZoomTransitioning = self.animationController()
        animationController.isPresentation = true
        return animationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        var animationController:ZoomTransitioning = self.animationController()
        animationController.isPresentation = false
        
        return animationController
    }
}

class ZoomTransitioning:Transitioning
{
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        var fromVC:UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UIViewController!
        var fromView = fromVC.view

        var toVC:UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UIViewController!
        var toView = toVC.view
        
        var containerView:UIView = transitionContext.containerView()
        
        let isPresentation = self.isPresentation
        
        var tintVC:UIViewController = DefaultTransitioning.tintInstance
        tintVC.view.backgroundColor = UIColor.blackColor()
        tintVC.view.userInteractionEnabled = false
        tintVC.view.alpha = isPresentation ? 0 : 0.5
        
        if (isPresentation)
        {
            containerView.addSubview(tintVC.view)
            containerView.addSubview(toView)
        }
        
        var animatingVC = isPresentation ? toVC : fromVC
        var animatingView = animatingVC.view
        
        /* incoming and outgoing frame for the view. iOS7 */
        var animatingFrameVC = isPresentation ? fromVC : toVC
        animatingView.frame = transitionContext.finalFrameForViewController(animatingFrameVC)
        
        var presentedTransform:CGAffineTransform = CGAffineTransformIdentity
        let scale:CGFloat = 0.001
        var dismissedTransform:CGAffineTransform = CGAffineTransformMakeScale(scale, scale)
        
        animatingView.transform = isPresentation ? dismissedTransform : presentedTransform
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 300.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.AllowUserInteraction|UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            animatingView.transform = isPresentation ? presentedTransform : dismissedTransform
            tintVC.view.alpha = isPresentation ? 0.5 : 0
        }) { (finished) -> Void in
            if (!self.isPresentation)
            {
                fromView.removeFromSuperview()
                tintVC.view.removeFromSuperview()
            }
            
            transitionContext.completeTransition(true)
        }
    }
    
}