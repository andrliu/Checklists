//
//  ViewController.swift
//  Checklists
//
//  Created by Andrew Liu on 12/21/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate
{
    var checklist: Checklist!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.rowHeight = 44
        title = checklist.name
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return checklist.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as UITableViewCell
        let item = checklist.items[indexPath.row]
        configureTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, withChecklistItem: item)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath)
        {
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        checklist.items.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "AddItem"
        {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as ItemDetailViewController
            controller.delegate = self
        }
        else if segue.identifier == "EditItem"
        {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell)
            {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem)
    {
        let label = cell.viewWithTag(1001) as UILabel
        if item.checked
        {
            label.text = "☑️"
        }
        else
        {
            label.text = ""
        }
    }
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem)
    {
        let label = cell.viewWithTag(1000) as UILabel
        label.text = item.text
        let dueDateLabel = cell.viewWithTag(1002) as UILabel
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        dueDateLabel.text = formatter.stringFromDate(item.dueDate)
    }
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    {
        checklist.items.append(item)
        checklist.sortChecklistItems()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
    {
        checklist.sortChecklistItems()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
}
