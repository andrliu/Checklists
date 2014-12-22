//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Andrew Liu on 12/21/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class
{
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item:ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate
{

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    weak var delegate: AddItemViewControllerDelegate?
    
    override func viewDidLoad()
        {
            super.viewDidLoad()
        }

    override func viewWillAppear(animated: Bool)
        {
            super.viewWillAppear(animated)
            textField.becomeFirstResponder()
        }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
        {
            return nil
        }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        let oldText: NSString = textField.text
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
//        if newText.length > 0
//        {
//            doneBarButton.enabled = true
//        }
//        else
//        {
//            doneBarButton.enabled = false
//        }
        doneBarButton.enabled = newText.length > 0
        return true
    }
    
    @IBAction func done()
        {
            let item = ChecklistItem()
            item.text = textField.text
            item.checked = false
            delegate?.addItemViewController(self, didFinishAddingItem: item)
        }
    
    @IBAction func cancel(sender: UIBarButtonItem)
        {
            delegate?.addItemViewControllerDidCancel(self)
        }
}
