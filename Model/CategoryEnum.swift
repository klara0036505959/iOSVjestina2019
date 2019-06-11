//
//  CategoryEnum.swift
//  QuizGame
//
//  Created by Five Admin on 4/3/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation
import UIKit

enum Category: String {
    
    case SPORTS = "SPORTS"
    case SCIENCE = "SCIENCE"
    case UNKNOWN
    
    var color: UIColor  {
        switch self {
        case.SCIENCE:
            return UIColor(red: 133/255, green: 196/255, blue: 120/255, alpha: 1.0)
        case.SPORTS:
            return UIColor(red: 110/255, green: 193/255, blue: 248/255, alpha: 1.0)
        case.UNKNOWN:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        }
        
    }
}


