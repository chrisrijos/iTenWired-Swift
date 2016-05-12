//
//  NotificationViewController.swift
//  Conference App
//
//  Created by Felipe on 5/11/16.
//  Copyright © 2016 Chrystech Systems. All rights reserved.
//

import UIKit

class NotificationViewController: UITableViewController {

    let notificationController = NotificationController()
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let notifications = notificationController.getAllNotifications()
        return notifications.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let notificationController = NotificationController()
        let notification = notificationController.getAllNotifications()[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("NotificationsCell") as? NotificationsCell
        
        cell?.build(notification)
        
        return cell!
    }
}