//
//  QuizService.swift
//  QuizGame
//
//  Created by Five Admin on 4/2/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation

class QuizService {
    
    func fetchQuizes
        (urlString: String, completion: @escaping ((Dict?) -> Void)){
        if let url = URL(string: urlString){
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
                if let data = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])

                        let dict = Dict(json: json)
                        let DATA = dict?.data
                        
                        var arrayOfQuizes:[Quiz] = []
                        var arrayOfQuestions:[Question] = []
                        
                        for element in (DATA as! Array<Any>){
                            let quizz = Quiz(json: element)
                            for quest in (quizz?.questions as! Array<Any>){
                                let qquestion = Question(json: quest)!
                                arrayOfQuestions.append(qquestion)
                            }
                            quizz?.questions = arrayOfQuestions
                            arrayOfQuestions.removeAll()
                            arrayOfQuizes.append(quizz!)
                        }
                        //var lista = [Quizz]()
                        dict?.data = arrayOfQuizes
                        /*
                        for nesto in arrayOfQuizes{
                            let kvizic = Quizz.createFrom(json: nesto)
                            if let kvizic = kvizic {
                                lista.append(kvizic)
                            }
                        }
                        dict?.data=lista
                      */
                        completion(dict)
                    }catch{
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        }else{
            completion(nil)
        }
    }
    
    
    
}
