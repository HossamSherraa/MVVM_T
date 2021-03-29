//
//  NewAccount.swift
//  Kooper_MVVM
//
//  Created by Hossam on 25/03/2021.
//

import Foundation
struct NewAccount {
    let name : String
    let fullName : String
    let email : String
    let password : String
    
    func isEmpty()->Bool{
        return name.isEmpty || fullName.isEmpty || email.isEmpty || password.isEmpty
    }
   
}
