

import Foundation
import CoreData
import UIKit

@objc(Quizz)
public class Quizz: NSManagedObject {
    
    class func getEntityName() -> String {
        return "Quizz"
    }
    
    class func firstOrCreate(withTitle title: String) -> Quizz? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Quizz> = Quizz.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", title)
        request.returnsObjectsAsFaults = false
        
        do {
            let reviews = try context.fetch(request)
            if let review = reviews.first {
                return review
            } else {
                let newReview = Quizz(context: context)
                return newReview
            }
        } catch {
            return nil
        }
    }
    
    class func createFrom(json: [String: Any]) -> Quizz? {
        if
            let title = json["display_title"] as? String,
            let summary = json["summary_short"] as? String,
            let date = json["publication_date"] as? String,
            let multimedia = json["multimedia"] as? [String: Any],
            let imageUrl = multimedia["src"] as? String {
            
            if let review = Quizz.firstOrCreate(withTitle: title) {
                review.date = date
                review.imageUrl = imageUrl
                review.title = title
                review.summary = summary
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return review
                } catch {
                    print("Failed saving")
                }
            }
        }
        return nil
    }
}
