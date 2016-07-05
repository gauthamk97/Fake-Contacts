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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Obtaining info on which person's name you clicked
        let person = contactPeople[currentSelectedContact.row]
        
        //Setting the details
        self.nameLabel?.text = person.valueForKey("name") as? String
        self.numberLabel?.text = person.valueForKey("number") as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
