//
//  ListDetailViewController.swift
//  GotDo
//
//  Created by Dmytro Aprelenko on 17.03.16.
//  Copyright © 2016 Dmytro Aprelenko. All rights reserved.
//

import UIKit
protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist)
    func listDetailViewController(controller: ListDetailViewController,
        didFinishEditingChecklist checklist: Checklist)
   }
    class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
            @IBOutlet weak var doneBarButton: UIBarButtonItem!
        @IBOutlet weak var textField: UITextField!
        @IBOutlet weak var iconImageView: UIImageView!
        
        weak var delegate: ListDetailViewControllerDelegate?
        var checklistToEdit: Checklist?
        var iconName = "Folder"



override func viewDidLoad() {
            super.viewDidLoad()
            if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.enabled = true
            iconName = checklist.icon
            }
    iconImageView.image = UIImage(named: iconName)
   }

override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
}

@IBAction func cancel() {
    delegate?.listDetailViewControllerDidCancel(self)
}

@IBAction func done() {
    if let checklist = checklistToEdit {
    checklist.name = textField.text!
        checklist.icon = iconName
    delegate?.listDetailViewController(self, didFinishEditingChecklist: checklist)
}
    else {
    let checklist = Checklist(name: textField.text!, icon: iconName)
    delegate?.listDetailViewController(self, didFinishAddingChecklist: checklist)
    }
    
        }
        
        override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
            if indexPath.section == 1 {
                return indexPath
            } else {
                return nil
                
            }
        }
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "PickIcon" {
                let controller = segue.destinationViewController as! IconPickerViewController
                controller.delegate = self
            }
        }
        
        func iconPicker(picker: IconPickerViewController, didPickIcon iconName: String) {
            self.iconName = iconName
            iconImageView.image = UIImage(named: iconName)
            navigationController?.popViewControllerAnimated(true)
        }


}


