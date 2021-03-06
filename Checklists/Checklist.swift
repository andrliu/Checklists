//
//  Checklist.swift
//  Checklists
//
//  Created by Andrew Liu on 12/22/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding
{
    var name = ""
    var iconName: String
    var items = [ChecklistItem]()
    
    convenience init(name: String)
    {
        self.init(name: name, iconName: "No Icon")
    }
    
    init(name: String, iconName: String)
    {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        name = aDecoder.decodeObjectForKey("Name") as String
        items = aDecoder.decodeObjectForKey("Items") as [ChecklistItem]
        iconName = aDecoder.decodeObjectForKey("IconName") as String
        super.init()
    }
    
    func sortChecklistItems()
    {
        items.sort({checklistItem1, checklistItem2 in return checklistItem1.dueDate.compare(checklistItem2.dueDate) == NSComparisonResult.OrderedAscending})
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items, forKey: "Items")
        aCoder.encodeObject(iconName, forKey: "IconName")
    }
    
    func countUncheckedItems() -> Int
    {
        var count = 0
        for item in items
        {
            if !item.checked
            {
                count += 1
            }
        }
        return count
    }
}
