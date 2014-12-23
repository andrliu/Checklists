//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Andrew Liu on 12/21/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding
{
    var text = ""
    var checked = false
    
    func toggleChecked()
    {
        checked = !checked
    }

    override init()
    {
        super.init()
    }

    required init(coder aDecoder: NSCoder)
    {
        text = aDecoder.decodeObjectForKey("Text") as String
        checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
}