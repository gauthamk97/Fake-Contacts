//
//  ContactsTableViewController.swift
//  Fake Contacts
//
//  Created by Gautham Kumar on 29/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import UIKit
import CoreData

class ContactsTableViewController: UITableViewController {

    var contactNames: [String]!
    var alphabetizedContactNames: [String : [String]]!
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        
        contactNames = ["Amrita","Ajay","Asad","Chetna","Dad","Deepak","Dhanush","Dipti","Divya","Manish","Karthik","Lavanya","Nikhil","Nikita","Nishanth","Shashanth","Shriya","Tanya","Vishnu"]
        
        alphabetizedContactNames = alphabetize(contactNames)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        let arrayOfKeys = alphabetizedContactNames.keys
        let sortedKeys = arrayOfKeys.sort()
        return sortedKeys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let arrayOfKeys = alphabetizedContactNames.keys
        let sortedKeys = arrayOfKeys.sort()
        
        let key = sortedKeys[section]
        
        return (alphabetizedContactNames[key]?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let arrayOfKeys = alphabetizedContactNames.keys
        let sortedKeys = arrayOfKeys.sort()
        
        let key = sortedKeys[indexPath.section]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        if let contacts = alphabetizedContactNames[key] {
             cell.textLabel?.text = contacts[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let arrayOfKeys = alphabetizedContactNames.keys
        let sortedKeys = arrayOfKeys.sort()
        
        let key = sortedKeys[section]
        
        return key
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("InformationController", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func OnAddButtonClick(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "AddorEditContact", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("ContactEditController")
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    private func alphabetize(array : [String]) -> [String : [String]] {
        var result: [String : [String]] = [:]
        
        for item in array {
            
            let index = item.startIndex.advancedBy(1)
            let firstLetter = item.substringToIndex(index)
            
            if result[firstLetter] == nil {
                result[firstLetter] = [item]
            }
            else {
                result[firstLetter]?.append(item)
            }
        }
        
        for (key,value) in result {
            result[key] = value.sort()
        }
        
        return result
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
