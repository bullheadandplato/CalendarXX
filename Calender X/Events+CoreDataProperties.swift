//
//  Events+CoreDataProperties.swift
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

extension Events {

    @NSManaged var day: NSNumber?
    @NSManaged var des: String?
    @NSManaged var month: NSNumber?
    @NSManaged var ac: Countries?

}
