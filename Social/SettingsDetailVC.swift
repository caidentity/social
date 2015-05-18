//
//  SettingsDetailVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/11/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import Foundation
import UIKit

class SettingsDetailVC: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var prepTime: UILabel?
    
    var nameString: String?
    var prepString: String?
    var imageName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Make this more dynamic later on
        self.title = "Detail";
        
        imageView?.image = UIImage(named: imageName!)
        nameLabel?.text = nameString!
        prepTime?.text = prepString!
    }
}