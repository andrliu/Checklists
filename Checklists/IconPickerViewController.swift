//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by Andrew Liu on 12/22/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

import UIKit

protocol IconPickerViewControllerDelegate: class
{
    func iconPicker(picker: IconPickerViewController, didPickIcon iconName: String)
}

class IconPickerViewController: UITableViewController
{
    weak var delegate: IconPickerViewControllerDelegate?
    let icons = ["No Icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.rowHeight = 44
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return icons.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("IconCell") as UITableViewCell
        let iconName = icons[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let delegate = delegate
        {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPickIcon: iconName)
        }
    }
}
