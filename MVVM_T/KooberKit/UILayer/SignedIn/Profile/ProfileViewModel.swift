//
//  ProfileViewModel.swift
//  MVVM_T
//
//  Created by Hossam on 31/03/2021.
//

import Foundation
//1- PresentViewData Using UserProfile
//2- repseonse to signout using 1- UserSsssionReposity Shared Instance , 2- ResponseTo SignoutView To Present ONboarding
protocol SignoutResponder {
    func signedout()
}
protocol DismissProfileResponder {
    func dismissProfile()
}
class ProfileViewModel{
    
    internal init(userSessionRepository: UserSessionRepository, userSession: UserSession, userProfile: UserProfile, signoutResponder: SignoutResponder, dismissProfileResponder: DismissProfileResponder) {
        self.userSessionRepository = userSessionRepository
        self.userSession = userSession
        self.userProfile = userProfile
        self.signoutResponder = signoutResponder
        self.dismissProfileResponder = dismissProfileResponder
    }
    
    
    let userSessionRepository : UserSessionRepository
    let userSession : UserSession
    let userProfile : UserProfile
    let signoutResponder : SignoutResponder
    let dismissProfileResponder : DismissProfileResponder
    
   
    
    @objc
    func onPressDismiss(){
        dismissProfileResponder.dismissProfile()
    }
    
    @objc
    func onPressSignout(){
        userSessionRepository.signout(userSession: userSession)
        signoutResponder.signedout()
    }
    
    func userProfileData() -> [String?] {
        [userProfile.name , userProfile.nickname , userProfile.email]
    }
    
        
}

