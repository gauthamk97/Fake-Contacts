//
//  AddorEditContactViewController.swift
//  Fake Contacts
//
//  Created by Gautham Kumar on 04/07/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import UIKit

class AddorEditContactViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var NumberText: UITextField!
    @IBOutlet var contactImage: UIView!
    
    var justHitReturn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        
        NameText.autocapitalizationType = .Words
        NameText.returnKeyType = .Next
        NumberText.keyboardType = .NumberPad

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddorEditContactViewController.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddorEditContactViewController.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    func keyboardWillShow(notif : NSNotification) {
        if justHitReturn {
            self.view.window?.frame.origin.y -= 90
        }
        else if NameText.editing {
            self.view.window?.frame.origin.y -= 70
        }
        else if NumberText.editing {
            self.view.window?.frame.origin.y -= 160
        }
        print("Showing")
    }

    func keyboardWillHide(notif : NSNotification) {
        self.view.window?.frame.origin.y = 0
        print("Hiding")
        justHitReturn = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        justHitReturn = true
        if textField == NameText {
            NumberText.becomeFirstResponder()
        }
        else {
            NumberText.resignFirstResponder()
        }
        return true
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.Default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(AddorEditContactViewController.doneButtonAction))
        
        let items = NSMutableArray()
        items.addObject(flexSpace)
        items.addObject(done)
        
        doneToolbar.items = [done]
        doneToolbar.sizeToFit()
        
        //self.textView.inputAccessoryView = doneToolbar
        self.NumberText.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.NumberText.resignFirstResponder()
    }
    
    @IBAction func OnClickSave(sender: AnyObject) {
    }
    
    
    @IBAction func OnCancelClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
