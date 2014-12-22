//
//  Checklist.swift
//  Checklists
//
//  Created by Andrew Liu on 12/22/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

import UIKit

class Checklist: NSObject
{
    var name = ""
    var items = [ChecklistItem]()
    init(name: String)
    {
        self.name = name
        super.init()
    }
}
