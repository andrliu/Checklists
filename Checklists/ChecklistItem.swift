//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Andrew Liu on 12/21/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject
{
    var text = ""
    var checked = false
    
    func toggleChecked()
    {
        checked = !checked
    }
}