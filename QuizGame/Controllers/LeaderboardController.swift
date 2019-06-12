//
//  LeaderboardControllerViewController.swift
//  QuizGame
//
//  Created by Five Admin on 6/5/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit

extension LeaderboardController : top20dataProtocol {
    func setArray20(usernames20: Array<String>, scores20: Array<String>) {
        usernamesView20 = usernames20
        scoresView20 = scores20
        print("---------------")
        print(usernames20)
    }
    
}


class LeaderboardController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func buttonExit(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    var usernamesView20: Array<String>=[]
    var scoresView20: Array<String>=[]
    
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var top20label: UILabel!
    @IBOutlet weak var top20tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernamesView20.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Top20CellTableViewCell", for: indexPath) as! Top20CellTableViewCell
        
    
        cell.userIdLabel.text = usernamesView20[indexPath.row]+" "+scoresView20[indexPath.row]
        cell.numberLabel.text=String(indexPath.row+1)+"."
        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        top20tableView.register(UINib(nibName: "Top20CellTableViewCell", bundle: nil), forCellReuseIdentifier: "Top20CellTableViewCell")
        self.top20tableView.delegate = self
        self.top20tableView.dataSource = self
        
        
    }
}
