//
//  AddItemViewController.swift
//  Checklists
//
//  Created by elliot xin on 9/16/17.
//  Copyright © 2017 elliot xin. All rights reserved.
//

import UIKit


protocol AddItemViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: AddItemViewController)
    func itemDetailViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem)
}

class AddItemViewController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddItemViewControllerDelegate?
    
    var itemToEdit: ChecklistItem?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit{
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    
    @IBAction func cancel() {
        
        delegate?.itemDetailViewControllerDidCancel(self)
        
    }
    
    @IBAction func done() {
        
        if let item = itemToEdit {
            
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: item)
            
        }else{
            
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAdding: item)

        }
        
    }
    

}

extension AddItemViewController
{
 
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        doneBarButton.isEnabled  =  (newText.length > 0)
        return true
    }
}
