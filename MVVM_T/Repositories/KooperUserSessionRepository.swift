//
//  KooperUserSessionRepository.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import Combine
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
                let profile = UserProfile(name: newAccount.fullName, nickname: newAccount.name, email: newAccount.email, password: newAccount.password)
                let useSession = UserSession(profile: profile, session: session, state: .signin)
                try datastore.save(userSession: useSession)
                return useSession
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
