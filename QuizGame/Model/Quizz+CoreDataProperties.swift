//
//  Quizz+CoreDataProperties.swift
//  QuizGame
//
//  Created by Five Admin on 6/5/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation
import CoreData


extension Quizz {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quizz> {
        return NSFetchRequest<Quizz>(entityName: "Quizz")
    }
    
    @NSManaged public var category: String?
    @NSManaged public var description2: String?
    @NSManaged public var id: Int?
    @NSManaged public var image: String?
    @NSManaged public var category: String?
    
    
}
