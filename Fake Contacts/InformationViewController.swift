//
//  InformationViewController.swift
//  Fake Contacts
//
//  Created by Gautham Kumar on 29/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import UIKit
import CoreData

class InformationViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Obtaining info on which person's name you clicked
        let person = contactPeople[selectedIDNumber]
        
        //Setting the details
        self.nameLabel?.text = person.valueForKey("name") as? String
        self.numberLabel?.text = person.valueForKey("number") as? String
        if let imageData = person.valueForKey("picture") as? NSData {
           self.contactImage.image = UIImage(data: imageData, scale: 1.0)
        }
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(InformationViewController.onClickEdit))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InformationViewController.updateContactDetails), name: haveToUpdateTableView, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func updateContactDetails() {
        //Obtaining info on which person's name you clicked
        let person = contactPeople[selectedIDNumber]
        
        //Setting the details
        self.nameLabel?.text = person.valueForKey("name") as? String
        self.numberLabel?.text = person.valueForKey("number") as? String
        if let imageData = person.valueForKey("picture") as? NSData {
            self.contactImage.image = UIImage(data: imageData, scale: 1.0)
        }
    }
    
    func onClickEdit() {
        
        print("Edit called")
        calledFromEdit = true
        let storyboard = UIStoryboard(name: "AddorEditContact", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("ContactEditController")
        
        presentViewController(controller, animated: true, completion: nil)
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
