//
//  CoreDataStackCreator.swift
//  MVVM_T
//
//  Created by Hossam on 28/03/2021.
//

import CoreData
class CoreDataStackCreator : CoreDataCreator {
    
    let container = NSPersistentContainer(name: "UserSessionModel")
    init() {
        container.loadPersistentStores { (completion, error) in
//            try! self.container.persistentStoreCoordinator.destroyPersistentStore(at: completion.url!, ofType: NSSQLiteStoreType, options: nil)
        }
    
    }
    func getContext() -> NSManagedObjectContext {
        container.viewContext
    }
    
    
}
