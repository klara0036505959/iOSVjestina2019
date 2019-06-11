//
//  Entity+CoreDataClass.swift
//  
//
//  Created by Five Admin on 6/5/19.
//
//

import Foundation
import CoreData

//@objc(Quizz)

public class QuizCD: NSManagedObject {
    /*
    class func getEntityName() -> String {
        return "Quizz"
    }
    
    class func firstOrCreate(withTitle title: String) -> QuizCD? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<QuizCD> = QuizCD.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", title)
        request.returnsObjectsAsFaults = false
        
        do {
            let reviews = try context.fetch(request)
            if let review = reviews.first {
                return review
            } else {
                let newReview = QuizCD(context: context)
                return newReview
            }
        } catch {
            return nil
        }
    }
    
    class func createFrom(json: Quiz) -> QuizCD? {
        if
            
            let id = json.id as Int?,
            let title = json.title as String?,
            let description2 = json.description as? String,
            let category = json.category as String?,
            let level = json.level as Int?,
            let image = json.image as? String,
            let questions = json.questions as? [Question]
         {
            
            if let quiz = QuizCD.firstOrCreate(withTitle: title) {
                quiz.title = title
                quiz.id=Int32(id)
                quiz.description2=description2
                quiz.category=category
                quiz.level=Int32(level)
                quiz.image=image
                quiz.questions=questions as NSObject
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return quiz
                } catch {
                    print("Failed saving")
                }
            }
        }
        return nil
    }
*/
}
