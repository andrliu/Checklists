//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Andrew Liu on 12/21/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

import UIKit

class ChecklistItem: NSObject, NSCoding
{
    var text = ""
    var checked = false
    var dueDate = NSDate()
    var shouldRemind = false
    var itemID: Int
    
    func toggleChecked()
    {
        checked = !checked
    }

    func scheduleNotification()
    {
        let existingNotification = notificationForThisItem()
        if let notification = existingNotification
        {
            UIApplication.sharedApplication().cancelLocalNotification(notification)
            println("Found an existing notification \(notification)")
        }
        if shouldRemind && dueDate.compare(NSDate()) != NSComparisonResult.OrderedAscending
        {
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = text
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.userInfo = ["ItemID": itemID]
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            println("Scheduled notification \(localNotification) for itemID \(itemID)")
        }
    }
    
    func notificationForThisItem() -> UILocalNotification?
    {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications as [UILocalNotification]
        for notification in allNotifications
        {
            if let number = notification.userInfo?["ItemID"] as? NSNumber
            {
                if number.integerValue == itemID
                {
                    return notification
                }
            }
        }
        return nil
    }
    
    deinit
    {
        let existingNotification = notificationForThisItem()
        if let notification = existingNotification
        {
            UIApplication.sharedApplication().cancelLocalNotification(notification)
            println("Removing existing notification \(notification)")
        }
    }
    
    override init()
    {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        text = aDecoder.decodeObjectForKey("Text") as String
        checked = aDecoder.decodeBoolForKey("Checked")
        dueDate = aDecoder.decodeObjectForKey("DueDate") as NSDate
        shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
        itemID = aDecoder.decodeIntegerForKey("ItemID") as Int
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
        aCoder.encodeInteger(itemID, forKey: "ItemID")
    }
}