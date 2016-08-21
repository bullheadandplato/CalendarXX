//
//  Countries+CoreDataProperties.swift
//  Calender X
//
//  Created by osama on 8/4/16.
//  Copyright © 2016 osama. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Countries {

    @NSManaged var eventCount: NSNumber?
    @NSManaged var name: String?
    @NSManaged var selected: NSNumber?
    @NSManaged var events: NSOrderedSet?

}
