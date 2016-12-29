//
//  CoreDataStack.swift
//  MyHappyGrowth
//
//  Created by Gytenis Mikulenas on 20/12/16.
//  Copyright © 2016 Gytenis Mikulėnas 
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataConfig {
    
    static let groupIdentifier = "group.com.yourappname.app"
    static let modelName = "DataModel"
    
    static let sqliteFile = { () -> String in
        
        if CoreDataConfig.isDebugMode {
            
            return "DataModelTest.sqlite"
            
        } else {
            
            return "DataModel.sqlite"
        }
    }()
    
    static let isDebugMode = false
}

// Inspired from: https://swifting.io/blog/2016/09/25/25-core-data-in-ios10-nspersistentcontainer/

final class CoreDataStack {
    
    //var errorHandler: (Error) -> Void = {_ in }
    var isLoadingInProgress: Bool = true
    var config: CoreDataConfig
    var logManager: LogManagerProtocol
    
    required init(logManager: LogManagerProtocol) {
        
        self.config = CoreDataConfig()
        self.logManager = logManager
        
        if CoreDataConfig.isDebugMode {
            
            // wipe previous data
            //[self deleteDatabases];
            //[self setupTestData]
        }
        
        self.persistentContainer = PersistentContainer(name: CoreDataConfig.modelName)
        
        // Add lightweight migration:
        // http://stackoverflow.com/a/39857699/597292
        let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        description.url = PersistentContainer.defaultDirectoryURL().appendingPathComponent("\(CoreDataConfig.modelName).sqlite")
        self.persistentContainer.persistentStoreDescriptions = [description]
        
        // Load shared core data
        self.persistentContainer.loadPersistentStores(completionHandler: { [weak self] (storeDescription, error) in
            
            self?.isLoadingInProgress = false
            
            if let error = error as NSError? {
                
                // http://stackoverflow.com/a/40823605/597292
                //
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                
                let errorMsg = "Unresolved error \(error), \(error.userInfo)"
                
                self?.logManager.debug(log: errorMsg)
                //fatalError(errorMessage)
            }
        })
    }
    
    // Perskaityk, kazkas idomaus: https://developer.apple.com/library/content/releasenotes/General/WhatNewCoreData2016/ReleaseNotes.html
    
    // CoreDataStack: https://swifting.io/blog/2016/09/25/25-core-data-in-ios10-nspersistentcontainer/
    
    var persistentContainer: PersistentContainer
    
    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    /*lazy var backgroundContext: NSManagedObjectContext = {
        
        return self.persistentContainer.newBackgroundContext()
    }()*/
    
    func execute(_ block: @escaping (NSManagedObjectContext) -> Void) {
        
        self.context.perform {
            block(self.context)
        }
    }
    
    func executeInBackground(_ block: @escaping (NSManagedObjectContext) -> Void) {
        
        self.persistentContainer.performBackgroundTask(block)
    }
    
    // MARK:
    // MARK: Internal
    // MARK:
    
    internal func deleteDatabases() {
        
        // TODO need to delete from app container group, not app bundle
        // delete production sqlite file
        var docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        var storeUrl: URL = docs.appendingPathComponent("DataModel.sqlite")
        do {
            try FileManager.default.removeItem(at: storeUrl)
        } catch let error as NSError {
            self.logManager.debug(log: error.localizedDescription)
        }
        
        // delete test sqlite file
        docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        storeUrl = docs.appendingPathComponent("DataModelTest.sqlite")
        do {
            try FileManager.default.removeItem(at: storeUrl)
        } catch let error as NSError {
            self.logManager.debug(log: error.localizedDescription)
        }
    }
}

final class PersistentContainer: NSPersistentContainer {
    override class func defaultDirectoryURL() -> URL {
        var url = super.defaultDirectoryURL()
        if let newURL =
            FileManager.default.containerURL(
                forSecurityApplicationGroupIdentifier: CoreDataConfig.groupIdentifier) {
            url = newURL
        }
        return url
    }
}

import ObjectiveC
private var xoAssociationKey: UInt8 = 0

extension NSManagedObjectContext {
    
    var logManager: LogManagerProtocol! {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? LogManagerProtocol
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    internal func entityName<T: NSManagedObject>(entity: T.Type) -> String {
        
        var name: String = NSStringFromClass(T.self)
        name = name.components(separatedBy: ".").last!
        
        return name
    }
    
    func saveContext(callback: @escaping Callback) {
        
        if self.hasChanges {
            do {
                
                try self.save()
                
                DispatchQueue.main.async {
                
                    callback(true, nil, nil, nil)
                }
                
            } catch let error {
                
                DispatchQueue.main.async {
                
                    let message = "Unable to save context: \(error)"
                    self.logManager.debug(log: message)
                    //fatalError(errorMessage)
                    
                    callback(false, nil, nil, ErrorEntity(code: nil, message: message))
                }
            }
        }
    }
    
    // Advanced version for executing complex custom queries
    internal func query<T: NSManagedObject>(entityType: T.Type, predicate: NSPredicate, includeSubentities: Bool, fetchProperties: [Any]?, groupByProperties: [Any]?, sortDescriptors: [NSSortDescriptor]?, resultType: NSFetchRequestResultType = NSFetchRequestResultType.countResultType, fromOffset: Int, withLimit: Int, callback: Callback) {
        
        let entityName: String = self.entityName(entity: entityType)
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
        
        #if DEBUG
            
            // Minor tweak for debugging, long story short: if you will just retrieve entities but won't access any of the properties, then printing these entities to console will show their values but will show ...data<fault>. But as we will do wrapping/unwrapping into other classes which will touch entity properties, it's not needed. However, still leaving it here
            fetchRequest.returnsObjectsAsFaults = false
            
        #endif
        
        // Set predicates (WHERE filters)
        fetchRequest.predicate = predicate
        
        // To fetch or not to fetch children table records
        fetchRequest.includesSubentities = includeSubentities
        
        if (sortDescriptors != nil) {
            
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        if (fromOffset >= 0) {
            
            fetchRequest.fetchOffset = fromOffset
        }
        
        if (withLimit > 0) {
            
            fetchRequest.fetchLimit = withLimit
        }
        
        // Change return type of result set
        fetchRequest.resultType = resultType
        
        // Selected columns
        if (fetchProperties != nil) {
            
            fetchRequest.propertiesToFetch = fetchProperties
        }
        
        if (groupByProperties != nil) {
            
            fetchRequest.propertiesToGroupBy = groupByProperties
        }
        
        // Execute
        do {
            
            let result = try self.fetch(fetchRequest)
            callback(true, result, nil, nil)
            
        } catch {
            
            self.logManager.debug(log: error.localizedDescription)
            //fatalError(errorMessage)
            callback(false, nil, nil, nil)
        }
    }
    
    // Simplified version for executing simple queries - SELECT * FROM table WHERE ...predicate...
    internal func query<T: NSManagedObject>(entityType: T.Type, predicate: NSPredicate, callback: Callback) {
        
        let entityName: String = self.entityName(entity: entityType)
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: entityName)
        
        #if DEBUG
            
            // Minor tweak for debugging, long story short: if you will just retrieve entities but won't access any of the properties, then printing these entities to console will show their values but will show ...data<fault>. But as we will do wrapping/unwrapping into other classes which will touch entity properties, it's not needed. However, still leaving it here
            fetchRequest.returnsObjectsAsFaults = false
            
        #endif
        
        // Set predicates (WHERE filters)
        fetchRequest.predicate = predicate
        
        // Execute
        do {
            
            let result = try self.fetch(fetchRequest)
            callback(true, result, self, nil)
            
        } catch {
            
            self.logManager.debug(log: error.localizedDescription)
            //fatalError(errorMessage)
            callback(false, nil, self, ErrorEntity(code: 0, message: error.localizedDescription))
        }
    }
}
