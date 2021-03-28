//
//  UserProfile+CoreDataClass.swift
//  MVVM_T
//
//  Created by Hossam on 28/03/2021.
//
//

import Foundation
import CoreData

@objc(UserProfile)
public class UserProfile: NSManagedObject {
    static func makeUserProfile(name : String? , nickname : String? , email : String? , password : String?)->UserProfile{
        let userProfile = UserProfile(context: context)
        userProfile.name = name
        userProfile.nickname = nickname
        userProfile.email = email
        userProfile.password = password
        return userProfile
    }
}
