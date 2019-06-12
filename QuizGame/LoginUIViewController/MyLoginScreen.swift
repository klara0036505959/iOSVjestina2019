//
//  LoginScreen.swift
//  QuizGame
//
//  Created by Five Admin on 5/7/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit

class MyLoginScreen: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBAction func loginClick(_ sender: UIButton) {
        self.animateEverythingOut();
        let loginService = LoginService()
        loginService.loginFunction(urlString: "https://iosquiz.herokuapp.com/api/session",username: usernameTextField.text!, password: passwordTextField.text!) { (e) in
            
            DispatchQueue.main.async {
                if let podaci = e {
                    //let myViewController = MyViewController()
                    //let myViewController = TabBarController()
                    //self.navigationController?.pushViewController(myViewController, animated: true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.switchToTabBarController()
                    })
                    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    //appDelegate.switchToTabBarController()
                    
                    
                    
                    //print(podaci)
                    //print("POKUSAJ")
                }else{
                    self.tryAgainLabel.isHidden=false;
                    self.setupCenter()
                    self.setupYcenter()
                    Thread.sleep(forTimeInterval: 0.3)
                    self.animateEverythingIn()
                    
                }
            }
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var tryAgainLabel: UILabel!
    
    //let login_url = "https://iosquiz.herokuapp.com/api/session"
    //let checksession_url = "https://iosquiz.herokuapp.com/api/session"
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        let value = userDefaults.string(forKey: "username")
        print(value)
        print(userDefaults.string(forKey: "token"))
        if (value != nil){
            //let myViewController = MyViewController()
            
            
            let myViewController = TabBarController()
            //animateEverything()
            self.navigationController?.popViewController(animated: true)
            self.navigationController?.pushViewController(myViewController, animated: true)
            
   
        }
        
        usernameTextField.text = "36505959"
        passwordTextField.text = "36505959"
        

    }
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateEverythingIn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        animateEverythingOut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCenter()
        setupAlpha(to: 0.0)
        self.loginImageView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        

    }
    func setupCenter(){
        
        self.loginImageView.center.x-=self.view.bounds.width
        self.usernameLabel.center.x-=self.view.bounds.width
        self.usernameTextField.center.x-=self.view.bounds.width
        self.passwordLabel.center.x-=self.view.bounds.width
        self.passwordTextField.center.x-=self.view.bounds.width
        self.loginButton.center.x-=self.view.bounds.width
        self.tryAgainLabel.center.x-=self.view.bounds.width
        

    }
    
    func setupYcenter(){
        self.loginImageView.center.y+=100
        self.usernameTextField.center.y+=100
        self.usernameLabel.center.y+=100
        self.passwordLabel.center.y+=100
        self.passwordTextField.center.y+=100
        self.loginButton.center.y+=100
        self.tryAgainLabel.center.y+=100
    }
    
    func setupAlpha(to: CGFloat){
        self.loginImageView.alpha=to
        self.usernameLabel.alpha=to
        self.usernameTextField.alpha=to
        self.passwordTextField.alpha=to
        self.passwordLabel.alpha=to
        self.loginButton.alpha=to
        self.tryAgainLabel.alpha=to
    }
    
    func animateEverythingIn(){
        
        UIView.animate(withDuration: 0.6, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.loginImageView.center.x+=self.view.bounds.width
            self.loginImageView.alpha=1.0
            
        }) { _ in
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.loginImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.usernameLabel.center.x+=self.view.bounds.width
            self.usernameTextField.center.x+=self.view.bounds.width
            self.usernameTextField.alpha=1.0
            self.usernameLabel.alpha=1.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.4, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.passwordTextField.center.x+=self.view.bounds.width
            self.passwordLabel.center.x+=self.view.bounds.width
            self.passwordTextField.alpha=1.0
            self.passwordLabel.alpha=1.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.6, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.loginButton.center.x+=self.view.bounds.width
            self.loginButton.alpha=1.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.8, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.tryAgainLabel.center.x+=self.view.bounds.width
            self.tryAgainLabel.alpha=1.0
        }) { _ in
        }
    }
    
    func animateEverythingOut(){
        
        
        UIView.animate(withDuration: 0.6, delay: 0.0, animations: {
            self.loginImageView.center.y-=100
            self.loginImageView.alpha=0.0
            
        }) { _ in
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.0, animations: {
            self.loginImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.2, animations: {
            self.usernameLabel.center.y-=100
            self.usernameTextField.center.y-=100
            self.usernameTextField.alpha=0.0
            self.usernameLabel.alpha=0.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.4, animations: {
            self.passwordTextField.center.y-=100
            self.passwordLabel.center.y-=100
            self.passwordTextField.alpha=0.0
            self.passwordLabel.alpha=0.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.6, animations: {
            self.loginButton.center.y-=100
            self.loginButton.alpha=0.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.8, animations: {
            self.tryAgainLabel.center.y-=100
            self.tryAgainLabel.alpha=0.0
        }) { _ in
        }
        
    }
   
    
}
