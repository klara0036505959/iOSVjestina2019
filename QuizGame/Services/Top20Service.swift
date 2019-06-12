//
//  LoginService.swift
//  QuizGame
//
//  Created by Five Admin on 5/7/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation

class Top20Service {
    
    
    func getTop20Function(urlString: String, quiz_id: Int, completion: @escaping ((Any?) -> Void)){
        
        if let url = URL(string: urlString){
            var request = URLRequest(url: url)
            print(url)
            request.httpMethod = "GET"
            
            do {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let defaults = UserDefaults.standard
                let token = defaults.string(forKey: "token")
                request.setValue(token, forHTTPHeaderField: "Authorization")
            
                
            } catch let error {
                print(error.localizedDescription)
            }
            let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
                if let data = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                        print(json)
                        
                        if let parseJSON=json{
                            
                            completion(parseJSON)
                        } else {
                            print("error")
                        }
                        
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
    
    
    
    func fetchLeaderboard(quiz_id: Int, urlString: String, completion: @escaping ((NSArray) -> Void)) {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        print(token)
        print("ssss")
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            
            request.httpMethod="GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.addValue(token, forHTTPHeaderField: "Authorization")
            
            print("jdahjdhjd")
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        print(data)
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSArray
                        if let parseJSON=json{
                            
                            completion(parseJSON!)
                            print("oK")
                        } else {
                            print("error")
                        }
                        
                    } catch {
                        print("error1")
                    }
                } else {
                    print("error2")                }
            }
            dataTask.resume()
        } else {
            print("error3")
        }
    }
    
    
    

}
