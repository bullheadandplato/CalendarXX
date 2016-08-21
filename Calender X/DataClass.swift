//
//  DataClass.swift
//  Calender X
//
//  Created by osama on 8/3/16.
//  Copyright © 2016 osama. All rights reserved.
//

import Foundation
import CoreData
public class DataClass{
    let countryEntityName = "Countries"
    let eventsEntityName = "Events"
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.osama.dfd" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("DataModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    //load data
    func initStore(){
        let fetchRequest = NSFetchRequest(entityName: countryEntityName)
        let predicate = NSPredicate(format: "%K == %@", "name","Pakistan")
        fetchRequest.predicate = predicate
        do{
            if managedObjectContext.countForFetchRequest(fetchRequest, error: nil) == 0 {
                let pak = NSEntityDescription.insertNewObjectForEntityForName(countryEntityName, inManagedObjectContext: self.managedObjectContext) as! Countries
                pak.name = "Amerirca (USA)"
                pak.selected = 0
                pak.eventCount = 5
                let event1 = NSEntityDescription.insertNewObjectForEntityForName(eventsEntityName, inManagedObjectContext: self.managedObjectContext) as! Events
                event1.day = 4
                event1.month = 7
                event1.des = "Independance Day"
                let event2 = NSEntityDescription.insertNewObjectForEntityForName(eventsEntityName, inManagedObjectContext: self.managedObjectContext) as! Events
                event2.day = 3
                event2.month = 5
                event2.des = "Bhug nang Day"
                let event3 = NSEntityDescription.insertNewObjectForEntityForName(eventsEntityName, inManagedObjectContext: self.managedObjectContext) as! Events
                event3.day = 6
                event3.month = 10
                event3.des = "Google Day"
                let event4 = NSEntityDescription.insertNewObjectForEntityForName(eventsEntityName, inManagedObjectContext: self.managedObjectContext) as! Events
                event4.day = 3
                event4.month = 2
                event4.des = "Youtube Day"
                let event5 = NSEntityDescription.insertNewObjectForEntityForName(eventsEntityName, inManagedObjectContext: self.managedObjectContext) as! Events
                event5.day = 7
                event5.month = 12
                event5.des = "Twitter Day"
                let relation = pak.mutableOrderedSetValueForKey("events")
                relation.addObject(event1)
                relation.addObject(event2)
                relation.addObject(event3)
                relation.addObject(event4)
                relation.addObject(event5)
                //other country
                let pak1 = NSEntityDescription.insertNewObjectForEntityForName(countryEntityName, inManagedObjectContext: self.managedObjectContext) as! Countries
                pak1.name = "Pakistan"
                pak1.selected = 0
                pak1.eventCount = 3
                let event6 = NSEntityDescription.insertNewObjectForEntityForName(eventsEntityName, inManagedObjectContext: self.managedObjectContext) as! Events
                event6.day = 23
                event6.month = 3
                event6.des = "Pakistan Day (23rd March 1947)"
                let event7 = NSEntityDescription.insertNewObjectForEntityForName(eventsEntityName, inManagedObjectContext: self.managedObjectContext) as! Events
                event7.day = 14
                event7.month = 8
                event7.des = "Independance Day"
                let event8 = NSEntityDescription.insertNewObjectForEntityForName(eventsEntityName, inManagedObjectContext: self.managedObjectContext) as! Events
                event8.day = 6
                event8.month = 9
                event8.des = "Defence Day"
                let rel2 = pak1.mutableOrderedSetValueForKey("events")
                rel2.addObject(event6)
                rel2.addObject(event7)
                rel2.addObject(event8)
                self.saveContext()

            }
        }
    }
    //MARK:- Data retrieval functions
    func getCountries()->[Countries]{
        let fetchRequest = NSFetchRequest(entityName: countryEntityName)
        var y = [Countries]()
        do{
            let x = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            y = x as! [Countries]
        }catch{
            print(error)
        }
        return y
    }
    func getSelectedEvents()->[EventsManipulation]{
        let fetchRequest = NSFetchRequest(entityName: eventsEntityName)
        let predicate = NSPredicate(format: "%K == %i" ,"ac.selected",1)
        fetchRequest.predicate = predicate
        var y = [Events]()
        do{
            let x = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            y = x as! [Events]
        }catch{
            print(error)
        }
        var events = [EventsManipulation]()
        for tmp in y{
            let tmp1 = EventsManipulation()
            tmp1.setAll(tmp.day!, month: tmp.month!, des: tmp.des!, country: (tmp.ac?.name!)!)
            events.append(tmp1)
        }
        return events
    }
    
    func setSelected(isSelected:Int, countryName:String){
        let fetchRequest = NSFetchRequest(entityName: countryEntityName)
        let predicate = NSPredicate(format: "%K == %@", "name",countryName)
        fetchRequest.predicate = predicate
        do{
            if managedObjectContext.countForFetchRequest(fetchRequest, error: nil) != 0 {
                print("Applying update")
                let x = try managedObjectContext.executeFetchRequest(fetchRequest).last as! Countries
                let pak = NSEntityDescription.insertNewObjectForEntityForName(countryEntityName, inManagedObjectContext: self.managedObjectContext) as! Countries
                pak.name = x.name
                pak.eventCount = x.eventCount
                pak.events = x.events
                pak.selected = isSelected
                managedObjectContext.deleteObject(x)
                saveContext()
            }
        }catch{
            print(error)
        }

    }
    
}
