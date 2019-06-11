//
//  LoginService.swift
//  QuizGame
//
//  Created by Five Admin on 5/7/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation

class Top20Service {
    private func httpRequest() {
        
        //create the url with NSURL
        let url = URL(string: "​https://iosquiz.herokuapp.com/api/score?quiz_id=<id>")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
    func getTop20Function(urlString: String, quiz_id: Int, completion: @escaping ((Any?) -> Void)){
        print("PROBEBE")

        let originalString = "​score?quiz_id=<id>"
        let customAllowedSet =  NSCharacterSet(charactersIn:"?_=<>").inverted
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
        //print(escapedString)
        
        var urlString2 = "​https://iosquiz.herokuapp.com/api/"+escapedString!
        print(urlString2)
        if let url = URL(string: urlString2){
            var request = URLRequest(url: url)
            print(url)
            request.httpMethod = "GET"
            let parameters:[String : Int] = ["quiz_id": quiz_id]
            
            do {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let defaults = UserDefaults.standard
                let token = defaults.string(forKey: "token")
                
                request.setValue(token, forHTTPHeaderField: "Authorization")
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                
                print(parameters)
                
            } catch let error {
                print(error.localizedDescription)
                print("GREŠKA!")
            }
            print("prvo")

            let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
                print("hahaha")

                if let data = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                        print(json)
                        print("drugo")
                        
                       // if let parseJSON = json {
                         //
                           // let token = parseJSON["token"] as? String
                           // let id = parseJSON["user_id"] as? Int
                            //let userDefaults = UserDefaults.standard
                            //userDefaults.set(id, forKey: "username")
                            //userDefaults.set(token, forKey: "token")
                            //print(token, id)
                            //completion(json)
                       // }
                        
                        completion(json)
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
