//
//  UserSession+CoreDataClass.swift
//  MVVM_T
//
//  Created by Hossam on 28/03/2021.
//
//

import Foundation
import CoreData

@objc(UserSession)
public class UserSession: NSManagedObject {
    enum State : String {
        case signout , signin
    }
    static func makeUserSession(profile : UserProfile? , session : Session?  , state : String?)->UserSession{
        let userSession = UserSession(context: context)
        userSession.userProfile = profile
        userSession.session = session
        userSession.state = state
        return userSession
    }
    
    func changeStateTo(state : State)->Self{
        self.state = state.rawValue
        return self
      }
}
