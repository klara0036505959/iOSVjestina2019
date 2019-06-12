//
//  CoreDataService.swift
//  QuizGame
//
//  Created by Five Admin on 6/11/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation
import UIKit
class CoreDataService {
    
    let persistanceManager=DataController.shared
    
    func saveToMemory(_ quizzes: [Quiz]) {
        
        
        for q in quizzes {
            print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
            createUniqueQuiz(q)
        }
    }
    
    //create Core Data object
    func createUniqueQuiz(_ quiz: Quiz) {
        //save a User to Core Data
        
        if checkForRepetitions(quiz) {
            var db=QuizCD(context: self.persistanceManager.context)
            //print(String(describing: type(of: UserEntity().user)), " ", String(describing: User.self))
            db.id=Int32(quiz.id)
            db.description2=quiz.description as! String
            
            switch  quiz.category{
            case "SCIENCE":
                db.category="SCIENCE"
            case "SPORTS":
                db.category="SPORTS"
            default:
                db.category="UNKNOWN"
            }
            
            db.image=quiz.image as! String
            db.level=Int32(quiz.level)
            db.title=quiz.title
            for q in quiz.questions as! Array<Question>{
                //print(q)
                let qu = q
                
                db.questions.append(QuestionCD(String(qu.id), qu.question, String(qu.correct_answer), qu.answers[0], qu.answers[1], qu.answers[2], qu.answers[3]))
                //
            }
            UserDefaults.standard.set(true, forKey: "changesHappened")
            self.persistanceManager.saveContext()
        }
    }
    
    //provjera da nema duplica
    func checkForRepetitions(_ quiz: Quiz) -> Bool {
        if UserDefaults.standard.bool(forKey: "changesHappened") != true {
            return true
        }
        
        var notFound=true
        let db = try persistanceManager.fetch(QuizCD.self)
        db.forEach{
            if Int32(quiz.id)==$0.id {
                notFound=false
            }
        }
        
        return notFound
    }
    
    func getQuizzesFromCD() -> [Quiz] {
        // guard let users=try! persistanceManager.context.fetch(Entity.fetchRequest()) as? [QuizCD] else {return}
        var quizzes=[Quiz]()
        //get quizzes from Core Data
        let db=persistanceManager.fetch(QuizCD.self)
        
        var qid: Int
        var qtitle: String
        var qdescription: String?
        var qcategory: String
        var qlevel: Int
        var qimage: String?
        var qquestions: [Question]=[]
        
        for quiz in db {
            qid=Int(quiz.id)
            qimage=quiz.image
            qlevel=Int(quiz.level)
            qtitle=quiz.title
            qdescription=quiz.description2
            qcategory = quiz.category
            /*
            switch quiz.category{
            case "SCIENCE":
                qcategory=Category.SCIENCE
            case "SPORTS":
                qcategory=Category.SPORTS
            default:
                qcategory=Category.UNKNOWN
            }
            */
            for q in quiz.questions {
                var answers=[String]()
                
                answers.append(q.answer1)
                answers.append(q.answer2)
                answers.append(q.answer3)
                answers.append(q.answer4)
                
                var bla = Question(Int(q.id)!, q.questionMark, answers: answers, Int(q.correctAnswer)!)
                qquestions.append(bla!)
            }
            quizzes.append(Quiz(id: qid, title: qtitle, description: qdescription!, category: qcategory, level: qlevel, image: qimage!, questions: qquestions) )
        }
        return quizzes
    }
    
    func deleteQuiz(_ quiz: Quiz) {
        
        let db=self.persistanceManager.fetch(QuizCD.self)
        
        for q in db {
            if q.id==Int32(quiz.id) {
                persistanceManager.delete(q)
            }
        }
        
        db.forEach{print($0.id, " ", $0.questions[0].answer1)}
    }
}

