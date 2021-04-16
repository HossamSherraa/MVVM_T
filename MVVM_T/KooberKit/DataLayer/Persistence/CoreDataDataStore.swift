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
      
        Just(Void())
            .tryMap{try context.fetch(UserSession.fetchRequest()) as? [UserSession]}
            .tryMap{
                let matchedSession = $0?.filter({$0.userProfile?.email == email && $0.userProfile?.password == password})
                if let matchedSession = matchedSession , !matchedSession.isEmpty {
                    return matchedSession.first
                }else {
                    throw GlobalErrors.any
                }
                
            }
            .compactMap({$0})
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
        .replaceEmpty(with: nil)
            .eraseToAnyPublisher()
           
        
    
            
    }
    
    
}

