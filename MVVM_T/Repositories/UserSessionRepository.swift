//
//  UserSessionRepository.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import Combine
//Signin , Signup , Signout , readCurrentUserSeasion
protocol UserSessionRepository {
    func signIn(email : String , password : String )->AnyPublisher<UserSession,Error>
    func signup(newAccount : NewAccount)->AnyPublisher<UserSession , Error>
    func signout(userSession : UserSession)
    func readCurrentUser()->AnyPublisher<UserSession? , Never>
}
