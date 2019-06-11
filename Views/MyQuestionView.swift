//
//  MyQuestionView.swift
//  QuizGame
//
//  Created by Five Admin on 4/3/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit

protocol MyQuestionViewProtocol : NSObjectProtocol{
    func buttonTapped()
}

protocol CorrectAnswerProtocol : NSObjectProtocol{
    func correctButtonTapped()
}

class MyQuestionView: UIView {
    
    @IBOutlet var labelQuestionAsked: UILabel!
    @IBOutlet var buttonAnsw1: UIButton!
    @IBOutlet var buttonAnsw2: UIButton!
    @IBOutlet var buttonAnsw3: UIButton!
    @IBOutlet var buttonAnsw4: UIButton!
    var quiz: Quiz
    var pitanje: Question
    //var dict : Dict
    let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
    weak var delegate : MyQuestionViewProtocol? = nil
    weak var delegate2 : CorrectAnswerProtocol? = nil

    
    @objc func buttonClicked(_ sender: UIButton) {
        
        if quiz.questions is Array<Question>{
            let question = pitanje
            let correctAnsw = question.answers[question.correct_answer]
            if sender === buttonAnsw1 {
                if buttonAnsw1.titleLabel?.text == correctAnsw{
                    buttonAnsw1.backgroundColor = .green
                    self.delegate2?.correctButtonTapped()
                }else {
                    buttonAnsw1.backgroundColor = .red
                }
            }else if sender === buttonAnsw2 {
                if buttonAnsw2.titleLabel?.text == correctAnsw{
                    buttonAnsw2.backgroundColor = .green
                    self.delegate2?.correctButtonTapped()
                }else {
                    buttonAnsw2.backgroundColor = .red
                }
            } else if sender === buttonAnsw3 {
                if buttonAnsw3.titleLabel?.text == correctAnsw{
                    buttonAnsw3.backgroundColor = .green
                    self.delegate2?.correctButtonTapped()
                }else {
                    buttonAnsw3.backgroundColor = .red
                }
            } else if sender === buttonAnsw4 {
                if buttonAnsw4.titleLabel?.text == correctAnsw{
                    buttonAnsw4.backgroundColor = .green
                    self.delegate2?.correctButtonTapped()
                }else {
                    buttonAnsw4.backgroundColor = .red
                }
            }
        }
        self.delegate?.buttonTapped()
    }
    
    // Ovaj init prima pravokutnik u kojem ce se ovaj CustomView iscrtati
    override init(frame: CGRect) {
        self.quiz = Quiz(json: "nee")!
        self.pitanje = Question(json: "ne")!

        super.init(frame: frame)
    }
    
    required init(frame: CGRect, quiz: Quiz, pitanje: Question) {
        self.quiz = quiz
        self.pitanje =  pitanje

        
        super.init(frame: frame)
        setupView()
        
        self.translatesAutoresizingMaskIntoConstraints = true
        buttonAnsw1.translatesAutoresizingMaskIntoConstraints = true
        buttonAnsw2.translatesAutoresizingMaskIntoConstraints = true
        buttonAnsw3.translatesAutoresizingMaskIntoConstraints = true
        buttonAnsw4.translatesAutoresizingMaskIntoConstraints = true
        labelQuestionAsked.translatesAutoresizingMaskIntoConstraints = true
        
        
        if quiz.questions is Array<Question>{
            let question = pitanje
            if (question.answers) != nil{
                
                
                labelQuestionAsked?.text = question.question
                buttonAnsw1.setTitle(question.answers[0], for: .normal)
                buttonAnsw2.setTitle(question.answers[1], for: .normal)
                buttonAnsw3.setTitle(question.answers[2], for: .normal)
                buttonAnsw4.setTitle(question.answers[3], for: .normal)
            }
        }
        
        guard let category = Category(rawValue: quiz.category) else {
            return
        }
        
        switch category {
        case .SPORTS:
            self.backgroundColor = Category.SPORTS.color
        case .SCIENCE:
            self.backgroundColor = Category.SCIENCE.color
        default:
            self.backgroundColor = Category.UNKNOWN.color
        }
        
    }
    
    // Ovaj init se poziva kada se CustomView inicijalizira iz .xib datoteke
    required init?(coder aDecoder: NSCoder) {
        self.quiz = Quiz(json: "nee")!
        self.pitanje = Question(json: "ne")!

        super.init(coder: aDecoder)
        
    }
    
    
    
    func setupView(){
        labelQuestionAsked = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 280, height: 50)))
        labelQuestionAsked.adjustsFontSizeToFitWidth = true
        labelQuestionAsked.numberOfLines = 2
        labelQuestionAsked.textAlignment = .center
        
        buttonAnsw1 = UIButton(frame: CGRect(origin: CGPoint(x: 10, y: 80), size: CGSize(width: 280, height: 50)))
        buttonAnsw1.setTitleColor(.black, for: .normal)
        buttonAnsw1.backgroundColor = .white
        
        buttonAnsw2 = UIButton(frame: CGRect(origin: CGPoint(x: 10, y: 140), size: CGSize(width: 280, height: 50)))
        buttonAnsw2.setTitleColor(.black, for: .normal)
        buttonAnsw2.backgroundColor = .white
        
        buttonAnsw3 = UIButton(frame: CGRect(origin: CGPoint(x: 10, y: 200), size: CGSize(width: 280, height: 50)))
        buttonAnsw3.setTitleColor(.black, for: .normal)
        buttonAnsw3.backgroundColor = .white
        
        buttonAnsw4 = UIButton(frame: CGRect(origin: CGPoint(x: 10, y: 260), size: CGSize(width: 280, height: 50)))
        buttonAnsw4.setTitleColor(.black, for: .normal)
        buttonAnsw4.backgroundColor = .white
        
        buttonAnsw1.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        buttonAnsw2.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        buttonAnsw3.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        buttonAnsw4.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        
        
        if let labelQuestionAsked = labelQuestionAsked {
            self.addSubview(labelQuestionAsked)
        }
        if let buttonAnsw1 = buttonAnsw1 {
            self.addSubview(buttonAnsw1)
        }
        if let buttonAnsw2 = buttonAnsw2 {
            self.addSubview(buttonAnsw2)
        }
        if let buttonAnsw3 = buttonAnsw3 {
            self.addSubview(buttonAnsw3)
        }
        if let buttonAnsw4 = buttonAnsw4 {
            self.addSubview(buttonAnsw4)
        }
        
//        containerView.addSubview(labelQuestionAsked)
//        containerView.addSubview(buttonAnsw1)
//        containerView.addSubview(buttonAnsw2)
//        containerView.addSubview(buttonAnsw3)
//        containerView.addSubview(buttonAnsw4)
//        
//        labelQuestionAsked.autoPinEdge(toSuperviewEdge: .top)
//        labelQuestionAsked.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
//        labelQuestionAsked.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
//        
//        buttonAnsw1.autoPinEdge(.top, to: .bottom, of: labelQuestionAsked, withOffset: 10.0)
//        buttonAnsw1.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
//        buttonAnsw1.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
//        
//        buttonAnsw2.autoPinEdge(.top, to: .bottom, of: buttonAnsw1, withOffset: 10.0)
//        buttonAnsw2.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
//        buttonAnsw2.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
//        
//        buttonAnsw3.autoPinEdge(.top, to: .bottom, of: buttonAnsw2, withOffset: 10.0)
//        buttonAnsw3.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
//        buttonAnsw3.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
//        
//        buttonAnsw4.autoPinEdge(.top, to: .bottom, of: buttonAnsw3, withOffset: 10.0)
//        buttonAnsw4.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
//        buttonAnsw4.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
//        buttonAnsw4.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    
}
