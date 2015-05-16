//
//  PopUpTransitioner.swift
//  Social
//
//  Created by Craig Aucutt on 5/15/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import UIKit

class PopUpTransitioningDelegate:NSObject, UIViewControllerTransitioningDelegate
{
    func presentationControllerForPresentedViewController(presented: UIViewController,
        presentingViewController presenting: UIViewController!,
        sourceViewController source: UIViewController) -> UIPresentationController?
    {
        return ZoomPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    func animationController() -> PopUpTransitioning
    {
        var animationController:PopUpTransitioning = PopUpTransitioning()
        return animationController
    }
    
    func animationControllerForPresentedController(presented: UIViewController,
        presentingController presenting: UIViewController,
        sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        var animationController:PopUpTransitioning = self.animationController()
        animationController.isPresentation = true
        return animationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        var animationController:PopUpTransitioning = self.animationController()
        animationController.isPresentation = false
        
        return animationController
    }
}

class PopUpTransitioning:Transitioning
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
        
        let tintedView:UIView = UIView()
        tintedView.frame = fromView.frame
        tintedView.backgroundColor = UIColor.TWGray7()
        tintedView.alpha = isPresentation ? 0.75 : 0
        
        //TODO: abstract this. Still playing around with this. --YSK 
        let scaleValue:CGFloat = 5
        let contextSize:CGSize = CGSizeMake(fromView.frame.size.width/scaleValue, fromView.frame.size.height/scaleValue)
        
        UIGraphicsBeginImageContextWithOptions(contextSize, true, 1)
        
        let rect:CGRect = CGRectMake(0, 0, contextSize.width, contextSize.height)
        
        fromView.drawViewHierarchyInRect(rect, afterScreenUpdates: false)
        UIGraphicsGetImageFromCurrentImageContext()
        
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        let subRect:CGRect = CGRectMake(0, 0, fromView.frame.size.width/scaleValue, fromView.frame.size.height/scaleValue)
        let subImageRef:CGImageRef = CGImageCreateWithImageInRect(snapshot.CGImage, subRect)
        let subImage:UIImage = UIImage(CGImage: subImageRef)!
        
        let imageToBlur = subImage
        let imageToBlurCI = CIImage(image: imageToBlur)
        let imageToBlurExtend = imageToBlurCI.extent()
        let radius = NSNumber(float: 0.5)
        let filterName = "CIGaussianBlur"
        let blurredImage = imageToBlurCI.imageByApplyingFilter(filterName, withInputParameters: [
            "inputRadius": radius,
            "InputImage" : imageToBlurCI!
            ])
        
        let resultedImageRef = CIContext(options: nil).createCGImage(blurredImage, fromRect: imageToBlurExtend)
        
        var imageView:UIImageView = UIImageView()
        
        // temp hack to get rid of a shadow around the view - I think it is happening when scaling down the image. -YSK
        imageView.frame = CGRectMake(-10, -10, toView.frame.size.width + 10, toView.frame.size.height + 20)
        
        var backgroundImage :UIImage = UIImage.alloc()
        backgroundImage = UIImage(CGImage: resultedImageRef)!

        imageView.image = backgroundImage
        
        if (isPresentation)
        {
            tintVC.view.addSubview(imageView)
            tintVC.view.addSubview(tintedView)
            containerView.addSubview(tintVC.view)
            containerView.addSubview(toView)
        }
        
        var animatingVC = isPresentation ? toVC : fromVC
        var animatingView = animatingVC.view
        
        /* incoming and outgoing frame for the view. iOS7 */
        var animatingFrameVC = isPresentation ? fromVC : toVC
        animatingView.frame = transitionContext.finalFrameForViewController(animatingFrameVC)
        
        var presentedTransform:CGAffineTransform = CGAffineTransformIdentity
        
        let scale:CGFloat = 0
        var dismissedTransform:CGAffineTransform = CGAffineTransformMakeScale(scale, scale)

        animatingView.transform = isPresentation ? dismissedTransform : presentedTransform
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay:0, usingSpringWithDamping:0.5, initialSpringVelocity:0, options: UIViewAnimationOptions.AllowUserInteraction|UIViewAnimationOptions.BeginFromCurrentState,
            animations: { () -> Void in
                
                animatingView.transform = isPresentation ? presentedTransform : dismissedTransform
                animatingView.center = isPresentation ? CGPointMake(animatingView.frame.size.width/2, animatingView.frame.size.height/2) : CGPointMake(animatingView.frame.size.width/2, animatingView.frame.size.height + 600)
                tintVC.view.alpha = isPresentation ? 1 : 0
                
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

