//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Five Admin on 6/5/19.
//
//

import Foundation
import CoreData


extension QuizCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizCD> {
        return NSFetchRequest<QuizCD>(entityName: "QuizCD")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String
    @NSManaged public var description2: String
    @NSManaged public var category: String
    @NSManaged public var level: Int32
    @NSManaged public var image: String
    @NSManaged public var questions: [QuestionCD]

}
