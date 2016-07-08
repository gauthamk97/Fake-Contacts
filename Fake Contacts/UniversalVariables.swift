//
//  UniversalVariables.swift
//  Fake Contacts
//
//  Created by Gautham Kumar on 05/07/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var IDNumber: Int = 1
var selectedIDNumber: Int!

var contactPeople: [NSManagedObject] = []
var contactNames: [String] = []
var contactNumbers: [String] = []

var filteredPeople: [NSManagedObject] = []

//var currentSelectedContact: NSIndexPath!

let haveToUpdateTableView = ".com.GK.updateTVRequired"

var calledFromEdit: Bool = false