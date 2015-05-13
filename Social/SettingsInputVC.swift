//
//  SettingsInputVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/11/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsInputVCDelegate : class
{
    func feedbackDidSubmit(controller: SettingsInputVC)
    func SettingsInputVCDidCancel(controller: SettingsInputVC);
}

class SettingsInputVC : UIViewController
{
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var submitFeedbackBarButton: UIBarButtonItem!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    let kTextViewHeightConstraint:CGFloat = 156
    let kStandardMarginBetweenSubviews:CGFloat = 12.0
    
    weak var delegate: SettingsInputVCDelegate?
    
    var userHadAlreadyTyped:Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.feedbackTextView.text = NSLocalizedString("Tell Edmodo what you would like to see.", comment: "Feedback placeholder text")
        self.feedbackTextView.textColor = UIColor.greenColor()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //used to show the keyboard once the controller is presented
        self.feedbackTextView.becomeFirstResponder()
        
        //used to adjust the textView height when the Predictive Bar is shown/hidden
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidChange:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidChange:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        //make sure to dismiss keyboard before the controller is dismissed.
        self.view.endEditing(true)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @IBAction func cancelSubmitFeedback(sender: AnyObject)
    {
        self.delegate?.SettingsInputVCDidCancel(self)
    }
    
    func keyboardDidChange(notification: NSNotification)
    {
        if let info = notification.userInfo
        {
            if let keyboardSizeString = info[UIKeyboardFrameEndUserInfoKey] as? NSValue
            {
                let keyboardSize = keyboardSizeString.CGRectValue()
                
                self.view.layoutIfNeeded()
                UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    
                    let totalMarginsHeight = (self.kStandardMarginBetweenSubviews * 2)
                    self.textViewHeightConstraint.constant = self.view.frame.height - (keyboardSize.height + totalMarginsHeight)
                    
                    self.view.layoutIfNeeded()
                    },
                    completion: nil
                )
            }
        }
    }
}

//MARK: - UITextViewDelegate
extension SettingsInputVC: UITextViewDelegate
{
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        if self.userHadAlreadyTyped == false
        {
            self.feedbackTextView.text = NSLocalizedString("", comment: "Empty String")
            self.feedbackTextView.textColor = UIColor.blackColor()
            self.userHadAlreadyTyped = true
        }
        return true
    }
}

