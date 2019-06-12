//
//  Question.swift
//  QuizGame
//
//  Created by Five Admin on 4/2/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation

class Question{
    let id: Int
    let question: String
    let answers:[String]
    let correct_answer: Int

    
    init?(json: Any) {
        
        if let jsonDict = json as? [String: Any],
            let id = jsonDict["id"] as? Int,
            let question = jsonDict["question"] as? String,
            let answers = jsonDict["answers"] as? [String],
            let correct_answer = jsonDict["correct_answer"] as? Int

        {
            self.id = id
            self.question = question
            self.answers = answers
            self.correct_answer = correct_answer

        } else {
            return nil
        }
    }
    
    
    init?(_ id: Int, _ questionMark: String, answers: [String], _ correctAnswer: Int) {
        self.id=id
        self.question=questionMark
        self.correct_answer=correctAnswer
        self.answers = answers
    }
}
