//
//  ProfileTableVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/15/15.
//  Copyright (c) 2015 caidentity. All rights reserved.
//

import UIKit

protocol SubScrollDelegate {
    func subScrollViewDidScroll(scrollView: UIScrollView)
}

class ProfileUpdate {
    var icon: UIImage
    var name: String
    var body: String
    
    init(icon: UIImage, name: String, body: String) {
        self.icon = icon
        self.name = name
        self.body = body
    }
    
}

class ProfileTableVC: UITableViewController {
    
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!

    override func viewDidLoad() {
        userLabel.textColor = UIColor.whiteColor()
        userLabel.font = UIFont.mysemiboldSystemFontOfSize(22)

        positionLabel.textColor = UIColor.whiteColor()
        positionLabel.font = UIFont.mySystemFontOfSize(15)
    }
    
    var delegate: SubScrollDelegate!
    var items: [ProfileUpdate] = [
        ProfileUpdate(icon: UIImage(named: "profile-quote")!, name: "Favorite Quote", body: " “I’ve missed more than 9,000 shots in my career. I’ve lost almost 300 games. 26 times I’ve been trusted to take the game's winning shot and missed. I’ve failed over and over and over again in my life and that's why I succeed.” - Michael Jordan"),
        ProfileUpdate(icon: UIImage(named: "profile-place")!, name: "Favorite Spot In The City", body: "Stable Cafe"),
        ProfileUpdate(icon: UIImage(named: "profile-know")!, name: "Something You May Not Know", body: "Been doing design and frontend since was 13."),
    ]
//    
//    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        self.delegate.subScrollViewDidScroll(scrollView)
//    }
    
    func getUpdate(indexPath: NSIndexPath) -> ProfileUpdate {
        return self.items[indexPath.row]
    }
    
    // Table methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 10 + 10 + 15 + heightOfLabel(getUpdate(indexPath).body, 17, self.tableView.frame.width) + 15
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileUpdateCell") as! ProfileUpdateCell
        cell.renderWithUpdate(getUpdate(indexPath))
        return cell
    }
    
}

class ProfileUpdateCell: UITableViewCell {
    @IBOutlet var profileIcon: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    
    func renderWithUpdate(update: ProfileUpdate) {
        profileIcon.image = update.icon
        nameLabel.text = update.name
        bodyLabel.text = update.body
        
        nameLabel.textColor = UIColor.TWGray7()
        nameLabel.font = UIFont.mysemiboldSystemFontOfSize(15)
        
        bodyLabel.textColor = UIColor.TWGray7()
        bodyLabel.font = UIFont.mySystemFontOfSize(14)

    }
    
}