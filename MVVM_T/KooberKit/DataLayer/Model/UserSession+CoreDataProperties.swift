//
//  UserSession+CoreDataProperties.swift
//  MVVM_T
//
//  Created by Hossam on 28/03/2021.
//
//

import Foundation
import CoreData


extension UserSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSession> {
        return NSFetchRequest<UserSession>(entityName: "UserSession")
    }

    @NSManaged public var state: String?
    @NSManaged public var userProfile: UserProfile?
    @NSManaged public var session: Session?

}

extension UserSession : Identifiable {

}
