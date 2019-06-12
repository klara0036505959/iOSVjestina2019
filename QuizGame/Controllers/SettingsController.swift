//
//  SettingsController.swift
//  QuizGame
//
//  Created by Five Admin on 6/5/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    var window: UIWindow?
    @IBAction func buttonLogoutTap(_ sender: Any) {

        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "token")
       animateEverythingOut()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.switchViewControllers()
        })
        
        
        
    }
    @IBOutlet weak var buttonLogOut: UIButton!
    @IBOutlet weak var imageLogOut: UIImageView!
    @IBOutlet weak var labelUsername: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = "USER IDENTIFICATION NUMBER: "+UserDefaults.standard.string(forKey: "username")!
        labelUsername.text = value

        // Do any additional setup after loading the view.
    }
    
    func animateEverythingOut(){
        
        
        UIView.animate(withDuration: 0.6, delay: 0.0, animations: {
            self.labelUsername.center.y-=100
            self.labelUsername.alpha=0.0
            
        }) { _ in
        }
        
        
        UIView.animate(withDuration: 0.6, delay: 0.2, animations: {
            self.buttonLogOut.center.y-=100
            self.buttonLogOut.alpha=0.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.4, animations: {
            self.imageLogOut.center.y-=100
            self.imageLogOut.alpha=0.0
        }) { _ in
        }
        
        
    }



}
