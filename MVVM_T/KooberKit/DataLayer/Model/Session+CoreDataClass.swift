//
//  Session+CoreDataClass.swift
//  MVVM_T
//
//  Created by Hossam on 28/03/2021.
//
//

import Foundation
import CoreData

@objc(Session)
public class Session: NSManagedObject {
    static func makeSession(token : String)->Session{
        let session = Session(context: context)
        session.token = token
        return session
    }
}
