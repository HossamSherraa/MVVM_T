//
//  FakeApi.swift
//  Kooper_MVVM
//
//  Created by Hossam on 27/03/2021.
//

import Combine

struct FakeRemoteApi : UserSessionRemoteApi {
   
    func signup(newAccount: NewAccount) -> AnyPublisher<Session , Never> {
        Just( Session.makeSession(token: "234234332"))
        .eraseToAnyPublisher()
    }
    
    
}
