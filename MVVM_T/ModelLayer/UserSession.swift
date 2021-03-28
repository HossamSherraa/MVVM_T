//
//  UserSeasion.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import CoreData

class UserSession : NSManagedObject {
    internal init(profile: UserProfile, session: Session, state: UserSession.State) {
        #warning("This Class Will Be created Usig CORE DATA")
        fatalError()
    }
    
    
    enum State {
        case signout , signin
    }
     //MARK:-Properties
    let profile : UserProfile = .init(name: "", nickname: "", email: "", password: "")
    let session : Session = .init(token: "")
    var state : State = .signin
    
      func changeStateTo(state : State)->Self{
        self.state = state
        return self
    }
}
