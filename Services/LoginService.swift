//
//  LoginService.swift
//  QuizGame
//
//  Created by Five Admin on 5/7/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation

class LoginService {
    
    func loginFunction(urlString: String, username: String, password: String, completion: @escaping ((Any?) -> Void)){
        if let url = URL(string: urlString){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters2: [String: Any] = [
                "Username":  username,   //vec sam postavila parametre ovdje radi lakseg testiranja
                "Password": password]   // da ne moram svaki put ukucavati prilikom logina
            
            let parameters = "username=" + username + "&" + "password=" + password
            
            request.httpBody = parameters.data(using: String.Encoding.utf8)
            /*
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject:
                    parameters, options: .prettyPrinted)
                print("did that")
                print(request, parameters)
            } catch let error {
                print(error.localizedDescription)
                print("GREŠKA!")
            }
            */
            let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
                if let data = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary

                        
                        if let parseJSON = json {
                            
                            let token = parseJSON["token"] as? String
                            let id = parseJSON["user_id"] as? Int
                            let userDefaults = UserDefaults.standard
                            userDefaults.set(id, forKey: "username")
                            userDefaults.set(token, forKey: "token")
                            //print(token, id)
                            completion(json)
                        }
                        
                    }catch{
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
                
            }
            dataTask.resume()
        }else {
            completion(nil)
        }
    }
    
}
