//
//  ResultService.swift
//  QuizGame
//
//  Created by Five Admin on 5/8/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation

class ResultService{
    
    func loginFunction(urlString: String, quiz_id: Int, user_id: Int, time: TimeInterval, no_of_correct: Int, completion: @escaping ((Any?) -> Void)){
        if let url = URL(string: urlString){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters:[String : Any] = ["quiz_id": quiz_id,"user_id": user_id,"time": time,"no_of_correct": no_of_correct]
            
            do {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let defaults = UserDefaults.standard
                let token = defaults.string(forKey: "token")
                
                request.setValue(token, forHTTPHeaderField: "Authorization")
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                

            } catch let error {
                print(error.localizedDescription)
                print("GREŠKA!")
            }
            
            let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
                if let data = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])

                        completion(json)
                    }catch{
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == ServerResponseEnum.OK.rawValue {
                    var responseCode: Int = httpStatus.statusCode
                    print(ServerResponseEnum.OK)
                    print("SENT TO SERVER SUCCESSFULLY")
                    
                }else{
                    print("FAILED TO SEND RESULTS")
                    print(response)
                }
                
                
            }
            dataTask.resume()
        }else {
            completion(nil)
        }
    }
    
    
    
}
