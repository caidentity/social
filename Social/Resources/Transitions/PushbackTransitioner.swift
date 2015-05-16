//
//  PushbackTransitioner.swift
//  Social
//
//  Created by Craig Aucutt on 5/15/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import UIKit

class PushbackTransitioning:Transitioning
{
    var offset: CGFloat?
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        self.isPresentation ? executePresentationAnimation(transitionContext) : executeDismissalAnimation(transitionContext)
    }

    func executePresentationAnimation(transitionContext: UIViewControllerContextTransitioning)
    {
        let inView = transitionContext.containerView()
        
        let timingFunction = kCAMediaTimingFunctionDefault
        
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        let toView = toViewController!.view
        let fromView = fromViewController!.view
        
        let viewFrame = fromView.frame
        
        if(self.offset == nil)
        {
            self.offset = viewFrame.size.height
        }
        
        inView.addSubview(fromView)
        let temp = UIView(frame: viewFrame)
        temp.backgroundColor = UIColor.blackColor()
        temp.userInteractionEnabled = false
        inView.addSubview(temp)
        inView.addSubview(toView)
        
        CATransaction.begin()
            let toPathAnimation = CABasicAnimation(keyPath: "transform")
            toPathAnimation.timingFunction = CAMediaTimingFunction(name: timingFunction)
            toPathAnimation.duration = self.transitionDuration(transitionContext)
        
            toPathAnimation.fromValue = NSValue(CATransform3D: CATransform3DMakeTranslation(0, self.offset!, 1.0))
            toPathAnimation.toValue = NSValue(CATransform3D: CATransform3DIdentity)
        
        
            let fromPathAnimation = CABasicAnimation(keyPath: "transform")
            fromPathAnimation.timingFunction = CAMediaTimingFunction(name: timingFunction)
            fromPathAnimation.fillMode = kCAFillModeForwards
            fromPathAnimation.removedOnCompletion = false
            fromPathAnimation.duration = self.transitionDuration(transitionContext)
        
            fromPathAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
            fromPathAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(0.93, 0.93, 1.0))
        
            CATransaction.setCompletionBlock { () -> Void in
                transitionContext.completeTransition(true)
            }
        
            toView.layer.addAnimation(toPathAnimation, forKey: "transform")
            fromView.layer.addAnimation(fromPathAnimation, forKey: "tranform")
        
            let bgAnimation = CABasicAnimation(keyPath: "opacity")
            bgAnimation.timingFunction = CAMediaTimingFunction(name: timingFunction)
            bgAnimation.duration = self.transitionDuration(transitionContext)
            bgAnimation.fromValue = NSNumber(float: 0.0)
            bgAnimation.toValue = NSNumber(float: 0.5)
            bgAnimation.fillMode = kCAFillModeForwards
            bgAnimation.removedOnCompletion = false
            temp.layer.addAnimation(bgAnimation, forKey: "opacity")
        CATransaction.commit()
        
    }
    
    func executeDismissalAnimation(transitionContext: UIViewControllerContextTransitioning)
    {
        let inView = transitionContext.containerView()
        let timingFunction = kCAMediaTimingFunctionDefault
        
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let toView = toViewController!.view
        let fromView = fromViewController!.view
        
        let viewFrame = fromView.frame
        
        if(self.offset == nil)
        {
            self.offset = viewFrame.size.height
        }
        
        inView.addSubview(fromView)
        let temp = UIView(frame: viewFrame)
        temp.backgroundColor = UIColor.blackColor()
        inView.addSubview(temp)
        inView.addSubview(toView)
        
        toView.frame = viewFrame
        
        CATransaction.begin()
        
        let toPathAnimation = CABasicAnimation(keyPath: "transform")
        toPathAnimation.timingFunction = CAMediaTimingFunction(name: timingFunction)
        toPathAnimation.duration = self.transitionDuration(transitionContext)
        
        toPathAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        toPathAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeTranslation(0, self.offset!, 1.0))
        
        
        toPathAnimation.fillMode = kCAFillModeForwards
        toPathAnimation.removedOnCompletion = false
        
        let fromPathAnimation = CABasicAnimation(keyPath: "transform")
        fromPathAnimation.timingFunction = CAMediaTimingFunction(name: timingFunction)
        fromPathAnimation.duration = self.transitionDuration(transitionContext)
        
        
        fromPathAnimation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(0.93, 0.93, 1.0))
        fromPathAnimation.toValue = NSValue(CATransform3D: CATransform3DIdentity)
        
        
        fromPathAnimation.fillMode = kCAFillModeForwards
        fromPathAnimation.removedOnCompletion = false
        
        CATransaction.setCompletionBlock { () -> Void in
            
            //fix for ios 8 bug
            if let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            {
                
                UIApplication.sharedApplication().keyWindow?.addSubview(toViewController.view)
            }
            
            transitionContext.completeTransition(true)
        }
        
        fromView.layer.addAnimation(fromPathAnimation, forKey: "transform")
        toView.layer.addAnimation(toPathAnimation, forKey: "transform")
        
        let bgAnimation = CABasicAnimation(keyPath: "opacity")
        bgAnimation.timingFunction = CAMediaTimingFunction(name: timingFunction)
        bgAnimation.duration = self.transitionDuration(transitionContext)
        bgAnimation.fromValue = NSNumber(float: 0.5)
        bgAnimation.toValue = NSNumber(float: 0.0)
        bgAnimation.fillMode = kCAFillModeForwards
        bgAnimation.removedOnCompletion = false
        temp.layer.addAnimation(bgAnimation, forKey: "opacity")
        CATransaction.commit()
        
    }
}