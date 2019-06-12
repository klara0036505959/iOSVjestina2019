//
//  ServerResponseEnum.swift
//  QuizGame
//
//  Created by Five Admin on 5/13/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation
enum ServerResponseEnum: Int{
    
    case OK = 200
    case FORBIDDEN = 403
    case NOT_FOUND = 404
    case UNAUTHORIZED = 401
    case BAD_REQUEST = 400
    
}

