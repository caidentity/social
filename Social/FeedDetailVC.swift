//
//  FeedDetailVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/9/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//

import UIKit

class FeedDetailVC: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postCommentTextField: UITextField!
    @IBOutlet weak var postCommentButton: UIButton!
    @IBOutlet weak var postCommentBottomConstraint: NSLayoutConstraint!
    
    var allowReplies = false
    var rowNumberFirstReply = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        self.tableView.registerNib(nibName, forCellReuseIdentifier: FeedDetailCell())
//        self.tableView.registerNib(nibName, forCellReuseIdentifier: FeedDetailCell.self)

        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset = UIEdgeInsets(top: tableView.contentInset.top, left: tableView.contentInset.bottom, bottom: 52.0, right: tableView.contentInset.right)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "didTapTableView:")
        tapGesture.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        //used to adjust the textView height when the Predictive Bar is shown/hidden
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowHandler:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHideHandler:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
        func didTapTableView(gesture: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
}




