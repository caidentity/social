//
//  ProfileVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/12/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import UIKit

let min_header: CGFloat = 22

class ProfileVC: UIViewController, UIScrollViewDelegate, SubScrollDelegate {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBarHidden = true;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBarHidden = true;
    }
    
    func subScrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset < 0 {
            println(offset)
            var headerTransform = CATransform3DIdentity
            let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            headerView.layer.transform = headerTransform
        } else {
            var headerTransform = CATransform3DIdentity
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-(headerView.bounds.height-min_header), -offset), 0)
            headerView.layer.transform = headerTransform
        }
        
        if (headerView.bounds.height-min_header) < offset {
            headerView.layer.zPosition = 3
        } else {
            containerView.layer.zPosition = 1
            headerView.layer.zPosition = 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedProfile" {
            let profileVC = segue.destinationViewController as! ProfileTableVC
            profileVC.delegate = self
        }
    }
}
