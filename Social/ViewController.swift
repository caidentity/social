//
//  ViewController.swift
//  Social
//
//  Created by Craig Aucutt on 5/9/15.
//  Copyright (c) 2015 Craig Aucutt. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    struct TableConstants {
        static let cellIdentifier = "Table Cell"
    }
    
    var controllerNames = ["Feed"]
    var controllerClasses = ["TableViewController"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllerNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableConstants.cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = controllerNames[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier(controllerClasses[indexPath.row]) as! UIViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}

