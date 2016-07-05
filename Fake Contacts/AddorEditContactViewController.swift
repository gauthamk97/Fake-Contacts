//
//  AddorEditContactViewController.swift
//  Fake Contacts
//
//  Created by Gautham Kumar on 04/07/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import UIKit
import CoreData

class AddorEditContactViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var NumberText: UITextField!
    @IBOutlet var contactImage: UIView!
    
    var justHitReturn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        
        //Setting appropriate keyboard types
        NameText.autocapitalizationType = .Words
        NameText.returnKeyType = .Next
        NumberText.keyboardType = .NumberPad

        if calledFromEdit {
            //Obtaining info on which person's name you clicked
            let person = contactPeople[currentSelectedContact.row]
            
            //Setting the details
            self.NameText.text = person.valueForKey("name") as? String
            self.NumberText.text = person.valueForKey("number") as? String
        }
        //Watching out for when keyboard pops up and when it hides - to adjust the screen
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddorEditContactViewController.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddorEditContactViewController.keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //Called when keyboard pops up
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

    //Called when keyboard hides
    func keyboardWillHide(notif : NSNotification) {
        self.view.window?.frame.origin.y = 0
        print("Hiding")
        justHitReturn = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //On clicking Return key
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
    
    //To add Done Button to NUMPAD
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
    
    //Functionality to Save Contact
    @IBAction func OnClickSave(sender: AnyObject) {
        
        if calledFromEdit {
            let person = contactPeople[currentSelectedContact.row]
            person.setValue(NameText.text!, forKey: "name")
            person.setValue(NumberText.text!, forKey: "number")
            contactPeople[currentSelectedContact.row] = person
            
            NSNotificationCenter.defaultCenter().postNotificationName(haveToUpdateTableView, object: self)
            
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        else {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
            
            let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            if NameText.text == "" || NumberText.text == "" {
                print("Save failed")
                dismissViewControllerAnimated(true, completion: nil)
            }
                
            else {
                person.setValue(NameText.text!, forKey: "name")
                person.setValue(NumberText.text!, forKey: "number")
                
                do {
                    try managedContext.save()
                    contactPeople.append(person)
                }
                catch let error as NSError {
                    print("We have an error : \(error)")
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName(haveToUpdateTableView, object: self)
                
                dismissViewControllerAnimated(true, completion: nil)
                
            }

        }
        
    }
    
    //If cancel is clicked
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
