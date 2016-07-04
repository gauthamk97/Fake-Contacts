//
//  ViewController.swift
//  Fake Contacts
//
//  Created by Gautham Kumar on 28/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var contactNames: [String]!
    var alphabetizedContactNames: [String : [String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        contactNames = ["Amrita","Ajay","Asad","Chetna","Dad","Deepak","Dhanush","Dipti","Divya","Manish","Karthik","Lavanya","Nikhil","Nikita","Nishanth","Shashanth","Shriya","Tanya","Vishnu"]
        
        alphabetizedContactNames = alphabetizeArray(contactNames)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return alphabetizedContactNames.keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let arrayOfKeys = alphabetizedContactNames.keys
        let sortedKeys = arrayOfKeys.sort()
        
        let key = sortedKeys[section]
        
        if let contacts = alphabetizedContactNames[key] {
            return contacts.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell Identifier", forIndexPath: indexPath)
        
        let arrayOfKeys = alphabetizedContactNames.keys
        let sortedKeys = arrayOfKeys.sort()
        
        let key = sortedKeys[indexPath.section]
        
        if let contacts = alphabetizedContactNames[key] {
            cell.textLabel?.text = contacts[indexPath.row]
        }
        
        return cell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let arrayOfKeys = alphabetizedContactNames.keys
        let sortedKeys = arrayOfKeys.sort()
        
        return sortedKeys[section]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let arrayOfKeys = alphabetizedContactNames.keys
        let sortedKeys = arrayOfKeys.sort()
        
        let key = sortedKeys[indexPath.section]
        
        if let contacts = alphabetizedContactNames[key] {
            print(contacts[indexPath.row])
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func alphabetizeArray(array: [String]) -> [String : [String]] {
        
        var result: [String : [String]] = [:]
        
        for item in array {
            let firstLetter = item.substringToIndex(item.startIndex.advancedBy(1)).uppercaseString
            
            if result[firstLetter] == nil {
                result[firstLetter] = [item]
            }
            else {
                result[firstLetter]?.append(item)
            }
        }
        
        for (key, value) in result {
            result[key] = value.sort({ (a, b) -> Bool in
                a.lowercaseString < b.lowercaseString
            })
        }
        
        return result
    }


}

