//
//  MainViewModel.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import Combine
class MainViewModel : SignedInResponder , SignoutResponder {
    func signedout() {
        view =  .onBoarding
    }
    
    func signedIn(userSession: UserSession) {
        view = .signedIn(userSession: userSession)
    }
    
    @Published var view : MainView = .launch
    
}
