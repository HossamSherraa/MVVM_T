//
//  KooperUserSessionRepository.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import Combine
import Foundation
protocol UserSessionDataStore {
    func save(userSession : UserSession) throws
    func get(email: String, password: String) -> AnyPublisher<UserSession , Error>
    func update(userSession : UserSession)
    func readCurrentUser()->AnyPublisher<UserSession? , Never>
}
protocol UserSessionRemoteApi{
    func signup(newAccount : NewAccount)->AnyPublisher<Session , Never>
}

struct KooperUserSessionRepository : UserSessionRepository{
    let datastore : UserSessionDataStore
    let remoteApi : UserSessionRemoteApi
    func signIn(email: String, password: String) -> AnyPublisher<UserSession, Error> {
        datastore.get(email: email, password: password)
    }
    
    func signup(newAccount: NewAccount) -> AnyPublisher<UserSession, Error> {
        remoteApi
            .signup(newAccount: newAccount)
            .tryMap{ session in
                print(newAccount)
                let profile = UserProfile.makeUserProfile(name: newAccount.fullName, nickname: newAccount.name, email: newAccount.email, password: newAccount.password)
                let userSession = UserSession.makeUserSession(profile: profile, session: session, state: UserSession.State.signin.rawValue)
                try datastore.save(userSession: userSession)
                return userSession
            }
            .eraseToAnyPublisher()
        
        
        
    }
    
    func signout(userSession: UserSession)  {
        let userSession = userSession.changeStateTo(state: .signout)
        datastore.update(userSession: userSession)
    }
    
    func readCurrentUser() -> AnyPublisher<UserSession?, Never> {
        datastore
            .readCurrentUser()
    }
    
    
}
