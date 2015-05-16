//
//  SettingsVC.swift
//  Social
//
//  Created by Craig Aucutt on 5/10/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView?
    
    struct STableCell {
        let name: String
        let settingicon: String
        //let vc: String
    }
    var STableCells = [STableCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Settings"
    
        initializeTheSTableCells()
        
        // Add LeftNav Button.
        self.addLeftNavItem()
    }
    
    // Add Barbutton
    func addLeftNavItem()
    {
        
        // hide default navigation bar button item
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        
        let buttonBack: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        buttonBack.frame = CGRectMake(0, 0, 20, 40)
        buttonBack.setImage(UIImage(named:"navbar-dismiss"), forState: UIControlState.Normal)
        buttonBack.addTarget(self, action: "leftNavButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
        
        self.navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: false)
        
    }
    
    // Right Barbutton Pressed
    func leftNavButtonClick(sender:UIButton!)
    {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func initializeTheSTableCells() {
        self.STableCells = [STableCell(name: "Email Address", settingicon: "settings-email"),
            STableCell(name: "Change Password", settingicon: "settings-password"),
            STableCell(name: "Change Title", settingicon: "settings-workingon"),
            STableCell(name: "What I'm Working On", settingicon: "settings-workingon"),
            STableCell(name: "Edit Profile", settingicon: "settings-workingon"),
            STableCell(name: "Logout", settingicon: "settings-workingon")]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "SettingsTableCell"
        
        var cell: SettingsTableCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as? SettingsTableCell
        
        if cell == nil {
            cell = SettingsTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        
        cell!.nameLabel!.text = STableCells[indexPath.row].name
        cell!.settingiconImageView!.image = UIImage(named:STableCells[indexPath.row].settingicon)
        
        //Some Styling Here
        cell!.nameLabel!.textColor = UIColor.TWGray7()
        cell!.nameLabel!.font = UIFont.mySystemFontOfSize(17)

        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return STableCells.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 78.0
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        STableCells.removeAtIndex(indexPath.row)
        
        tableView.reloadData()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SettingsDetailVC" {
            let index = self.tableView?.indexPathForSelectedRow()
            var destinationViewController: SettingsDetailVC = segue.destinationViewController as! SettingsDetailVC
            
            destinationViewController.nameString = STableCells[index!.row].name
            destinationViewController.imageName = STableCells[index!.row].settingicon
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //        var cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        //        if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
        //            cell.accessoryType = UITableViewCellAccessoryType.None
        //        } else {
        //            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        //        }
        //        //let alert: UIAlertView = UIAlertView(title: "Message", message: STableCells[indexPath.row], delegate: nil, cancelButtonTitle: "OKAY")
        //        //alert.show()
    }
    
    
}