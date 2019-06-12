
    import Foundation
    import UIKit
    
    public class QuestionCD: NSObject, NSCoding {
        
        let id: String
        let questionMark: String
        let correctAnswer: String
        let answer1: String
        let answer2: String
        let answer3: String
        let answer4: String
        
        init(_ id: String, _ questionMark: String, _ correctAnswer: String, _ answer1: String, _ answer2: String, _ answer3: String, _ answer4: String) {
            self.id=id
            self.questionMark=questionMark
            self.correctAnswer=correctAnswer
            self.answer1=answer1
            self.answer2=answer2
            self.answer3=answer3
            self.answer4=answer4
        }
        
        public required convenience init(coder decoder: NSCoder) {
            var questionValues = [String:String]()
            var sdd=decoder.decodeObject(forKey: "answer3") as! String
            var sd=decoder.decodeObject(forKey: "correctAnswer")
            questionValues["id"] = decoder.decodeObject(forKey: "id") as! String
            questionValues["questionMark"] = decoder.decodeObject(forKey: "questionMark") as! String
            questionValues["correctAnswer"] = decoder.decodeObject(forKey: "correctAnswer") as! String
            
            questionValues["answer1"] = decoder.decodeObject(forKey: "answer1") as! String
            questionValues["answer2"] = decoder.decodeObject(forKey: "answer2") as! String
            questionValues["answer3"] = decoder.decodeObject(forKey: "answer3") as! String
            questionValues["answer4"] = decoder.decodeObject(forKey: "answer4") as! String
            
            self.init(questionValues["id"] as! String, questionValues["questionMark"] as! String, questionValues["correctAnswer"] as! String, questionValues["answer1"] as! String, questionValues["answer2"] as! String, questionValues["answer3"] as! String, questionValues["answer4"] as! String)
        }
        
        public func encode(with coder: NSCoder) {
            coder.encode(self.id, forKey: "id")
            coder.encode(self.questionMark, forKey: "questionMark")
            coder.encode(self.correctAnswer, forKey: "correctAnswer")
            
            coder.encode(self.answer1, forKey: "answer1")
            coder.encode(self.answer2, forKey: "answer2")
            coder.encode(self.answer3, forKey: "answer3")
            coder.encode(self.answer4, forKey: "answer4")
        }
        
    }
    
    
