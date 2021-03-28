//
//  Session+CoreDataProperties.swift
//  MVVM_T
//
//  Created by Hossam on 28/03/2021.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var token: String?
    @NSManaged public var usersession: UserSession?

}

extension Session : Identifiable {

}
