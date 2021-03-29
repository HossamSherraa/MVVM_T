//
//  SignupViewModel.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import Foundation
import Combine
class SignupViewModel {
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
    var nameText : String = ""
    var nicknameText : String = ""
    
    @Published var isButtonEnabled = true
    @Published var isIndicatorAnimation = true
    @Published var isEmailTextFieldDisabled = true
    @Published var isPasswordTextFieldDisabled = true
    @Published var isNameTextFieldDisabled = true
    @Published var isNicknameTextFieldDisabled = true
    
    
    @objc
    func onPressSignup(){
        let newAccount = NewAccount(name: nicknameText, fullName: nameText, email: emailText, password: passwordText)
        Just(newAccount)
            .tryMap({
                if $0.isEmpty()
                {throw GlobalErrors.any }
                else {return $0}
            })
            
            .flatMap({self.sessionRepository.signup(newAccount: $0)})
            .sink(receiveCompletion:
                    { [weak self] in
                        isError( $0, message: "please fill all fields", sender: self?.errorPublisher) { self?.chnageStateToNormal() }
                    }, receiveValue: {[weak self]  userSession  in
                        self?.chnageStateToLoading()
                        self?.signedInResponder.signedIn(userSession: userSession)
                    })
            .store(in: &subscriptions)
        
        
    }
    func chnageStateToNormal(){
        isButtonEnabled = true
        isIndicatorAnimation = true
        isEmailTextFieldDisabled = true
        isPasswordTextFieldDisabled = true
        isNameTextFieldDisabled = true
        isNicknameTextFieldDisabled = true
        
    }
    
    func chnageStateToLoading(){
        isButtonEnabled = false
        isIndicatorAnimation = false
        isEmailTextFieldDisabled = false
        isPasswordTextFieldDisabled = false
        isNameTextFieldDisabled = false
        isNicknameTextFieldDisabled = false
        
    }
    
}


func isError(_ completion :Subscribers.Completion<Error>  , message : String , sender :PassthroughSubject<String , Never>?  , _ completionHandeler : (()->Void)?) {
    switch completion {
    case .failure(_):
        if let completionHandeler = completionHandeler{
            completionHandeler()
        }
        sender?.send(message)
    default:
        break
    }
    
}
