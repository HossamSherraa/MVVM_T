//
//  CoreDataDataStore.swift
//  Kooper_MVVM
//
//  Created by Hossam on 27/03/2021.
//

import CoreData
import Combine

protocol CoreDataCreator {
    func getContext()->NSManagedObjectContext
}
enum  GlobalErrors : Error {
    case any
}
class CoreDataDataStore : UserSessionDataStore{

    init(coreDataCreator : CoreDataCreator) {
        context = coreDataCreator.getContext()

    }
    func save(userSession: UserSession) throws {
        context.insert(userSession)
        try! context.save()
    }
    
    func get(email: String, password: String) -> AnyPublisher<UserSession , Error> {
      let allUsers =  try! context.fetch(UserSession.fetchRequest()) as! [UserSession]
        return allUsers.publisher
            .filter({ userSession -> Bool in
                userSession.userProfile?.email == email && userSession.userProfile?.password == password
            })
            .tryFirst(where: { session in
                guard session.userProfile?.email == email else { throw GlobalErrors.any}
                return true
            })
            .eraseToAnyPublisher()
 
    }
    
    func update(userSession: UserSession) {
       try? userSession.managedObjectContext?.save()
    }
    
    func readCurrentUser() -> AnyPublisher<UserSession?, Never> {
        let allUsers =  try! context.fetch(UserSession.fetchRequest()) as? [UserSession] ?? []
       return allUsers
            .publisher
            .compactMap({$0})
        .filter({$0?.state == UserSession.State.signin.rawValue})
            .first()
            .eraseToAnyPublisher()
           
        
    
            
    }
    
    
}

