//
//  ContactsTableViewController.swift
//  Fake Contacts
//
//  Created by Gautham Kumar on 29/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import UIKit
import CoreData

class ContactsTableViewController: UITableViewController, UISearchControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var contactsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        
        //To check if table must be updated after adding/editing a contact
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ContactsTableViewController.updateContacts), name: haveToUpdateTableView, object: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Displays an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    //To fetch existing data
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            contactPeople = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactPeople.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        let contactPerson = contactPeople[indexPath.row]
        
        cell.textLabel?.text = contactPerson.valueForKey("name") as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        currentSelectedContact = indexPath
        
        //Moving to InformationsViewController
        performSegueWithIdentifier("InformationController", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //Brings up AddorEditContact Storyboard
    @IBAction func OnAddButtonClick(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "AddorEditContact", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("ContactEditController")
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    //This function is called by a NSNotification
    func updateContacts() {
        contactsTable.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
