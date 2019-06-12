//
//  ImageService.swift
//  QuizGame
//
//  Created by Five Admin on 4/3/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import Foundation
import UIKit


class ImageService {
   
    func fetchImages(urlString: String,completion: @escaping ((UIImage?) -> Void)){

        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("fetched image")
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                    print("completion called")
                } else {
                    completion(nil)
                }
            }
            //print("resuming data task")
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
}
