//
//  LeaderboardControllerViewController.swift
//  QuizGame
//
//  Created by Five Admin on 6/5/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit

class LeaderboardController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func buttonExit(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var top20label: UILabel!
    @IBOutlet weak var top20tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Top20CellTableViewCell", for: indexPath) as! Top20CellTableViewCell
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let quizService = QuizService()
        


        
        cell.userIdLabel.text = "kekek"
        
        return cell
    }
        
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        top20tableView.register(UINib(nibName: "Top20CellTableViewCell", bundle: nil), forCellReuseIdentifier: "Top20CellTableViewCell")
        self.top20tableView.delegate = self
        self.top20tableView.dataSource = self
        
        let top20Service = Top20Service()
        print("OKKKKK")
        top20Service.getTop20Function(urlString: "​https://iosquiz.herokuapp.com/api/score?quiz_id=<id>",quiz_id: 4) { (e) in
            DispatchQueue.main.async {
                if let podaci = e {
                    
                    print(podaci)
                    //print("POKUSAJ")
                }else{
                    print("TRY AGAIBBBB")
                }
            }
        }
        // Do any additional setup after loading the view.
    }


}
