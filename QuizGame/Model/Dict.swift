//
//  Dict.swift
//  QuizGame
//
//  Created by Five Admin on 4/2/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation

class Dict {
    var data:Any
    
    init?(json: Any) {

        if let jsonDict = json as? [String: Any],
            let data = jsonDict["quizzes"]
            
        {
            self.data=data
            
        } else {
            return nil
        }
    }
}
