//
//  Quiz.swift
//  QuizGame
//
//  Created by Five Admin on 4/2/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation


class Quiz {
    let id: Int
    let title: String
    let description: Any
    let category: String
    let level: Int
    let image: Any
    var questions: Any
    
    init?(json: Any) {
        
        if let jsonDict = json as? [String: Any],
            let id = jsonDict["id"] as? Int,
            let title = jsonDict["title"] as? String,
            let description = jsonDict["description"],
            let category = jsonDict["category"] as? String,
            let level = jsonDict["level"] as? Int,
            let image = jsonDict["image"],
            let questions = jsonDict["questions"]
        {
            self.id = id
            self.title = title
            self.description = description
            self.category = category
            self.level = level
            self.image = image
            self.questions = questions
            
        } else {
            return nil
        }
    }
    
    init(id: Int, title: String, description: String, category: String, level: Int, image: String, questions: Any) {
        
        self.id=id
        self.title=title
        self.description=description
        self.category=category
        self.level=level
        self.image=image
        self.questions=questions
    }
}
