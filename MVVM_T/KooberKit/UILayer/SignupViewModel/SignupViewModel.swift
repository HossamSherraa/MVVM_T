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
    @Published var isIndicatorAnimation = false
    @Published var isEmailTextFieldDisabled = false
    @Published var isPasswordTextFieldDisabled = false
    @Published var isNameTextFieldDisabled = false
    @Published var isNicknameTextFieldDisabled = false
    
    
    @objc
    func onPressSignup(){
        let newAccount = NewAccount(name: nicknameText, fullName: nameText, email: emailText, password: passwordText)
        self.chnageStateToLoading()
        sessionRepository.signup(newAccount: newAccount)
            .sink(receiveCompletion:
                    { [weak self] in
                        self?.chnageStateToNormal()
                        isError( $0, message: "FaildTo", sender: self?.errorPublisher)
                        
                    }, receiveValue: { userSession  in
                        self.signedInResponder.signedIn()
                    })
            .store(in: &subscriptions)


    }
    func chnageStateToNormal(){
         isButtonEnabled = true
         isIndicatorAnimation = false
         isEmailTextFieldDisabled = false
         isPasswordTextFieldDisabled = false
         isNameTextFieldDisabled = false
         isNicknameTextFieldDisabled = false
    }
    
    func chnageStateToLoading(){
         isButtonEnabled = false
         isIndicatorAnimation = true
         isEmailTextFieldDisabled = true
         isPasswordTextFieldDisabled = true
         isNameTextFieldDisabled = true
         isNicknameTextFieldDisabled = true
    }
    
}


func isError(_ completion :Subscribers.Completion<Error>  , message : String , sender :PassthroughSubject<String , Never>? ) {
    switch completion {
    case .failure(_):
        sender?.send(message)
    default:
        break
    }

}
