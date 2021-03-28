//
//  UserProfile+CoreDataProperties.swift
//  MVVM_T
//
//  Created by Hossam on 28/03/2021.
//
//

import Foundation
import CoreData


extension UserProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfile> {
        return NSFetchRequest<UserProfile>(entityName: "UserProfile")
    }

    @NSManaged public var name: String?
    @NSManaged public var nickname: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var usersession: UserSession?

}

extension UserProfile : Identifiable {

}
