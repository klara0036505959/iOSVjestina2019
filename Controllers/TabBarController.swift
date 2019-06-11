//
//  TabBarController.swift
//  QuizGame
//
//  Created by Five Admin on 6/5/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewController = MyViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "HOME", image: nil, tag: 0)
        
        let secondViewController = SearchController()
        secondViewController.tabBarItem = UITabBarItem(title: "SEARCH", image: nil, tag: 1)
        
        let thirdViewController = SettingsController()
        thirdViewController.tabBarItem = UITabBarItem(title: "SETTINGS", image: nil, tag: 2)
        
        let tabBarList = [firstViewController, secondViewController, thirdViewController]
        
        viewControllers = tabBarList

    }
    

}
