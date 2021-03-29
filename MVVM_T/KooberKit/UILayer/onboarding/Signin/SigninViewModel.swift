//
//  SignInViewModel.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import Combine
import Foundation
class SigninViewModel {
    let signedInResponder : SignedInResponder
    let sessionRepository : UserSessionRepository
    
    var subscriptions = Set<AnyCancellable>()
    init( sessionRepository : UserSessionRepository, signedInResponder : SignedInResponder) {
        self.sessionRepository = sessionRepository
        self.signedInResponder = signedInResponder
    }
    var errorPublisher = PassthroughSubject<String , Never>()
    
    var emailText : String = ""
    var passwordText : String = ""
    
    @Published var isButtonEnabled = true
    @Published  var isIndicatorAnimation = true
    @Published var isEmailTextFieldDisabled = true
    @Published var isPasswordTextFieldDisabled = true
    
    @objc
    func onSignin(){
    
        sessionRepository.signIn(email: emailText, password: passwordText)
            .sink { [weak self]  completion in
                
                switch completion {
                case .failure :
                    self?.changeStateToNormal()
                    self?.errorPublisher.send("Faild To Sign In ")
                default : break
                }
            } receiveValue: { [weak self] userSession in
                self?.signedInResponder.signedIn(userSession: userSession)
                self?.changeStateToLoading()
            }
            .store(in: &subscriptions)


    }
    
    
    func changeStateToNormal() {
         isButtonEnabled = true
         isIndicatorAnimation = true
         isEmailTextFieldDisabled = true
         isPasswordTextFieldDisabled = true
    }
    
    func changeStateToLoading() {
        isButtonEnabled = false
        isIndicatorAnimation = false
        isEmailTextFieldDisabled = false
        isPasswordTextFieldDisabled = false 
        
    }
}



