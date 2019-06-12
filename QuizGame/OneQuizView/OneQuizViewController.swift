//
//  OneQuizViewController.swift
//  QuizGame
//
//  Created by Five Admin on 5/6/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit
import PureLayout


protocol top20dataProtocol : NSObjectProtocol{
    func setArray20(usernames20: Array<String>, scores20: Array<String>)
}

extension OneQuizViewController : MyQuestionViewProtocol {
    func buttonTapped() {
        brojOdgovorenih=brojOdgovorenih!+1;
        var tocka: CGPoint = oneQuizScrollView.contentOffset
        tocka.x = tocka.x + slides[0].frame.width
        oneQuizScrollView.setContentOffset(tocka, animated: true)
        
    
        if brojOdgovorenih == slides.count{
            trajanje = Date.init().timeIntervalSince(pocetak!)
            startOneQuizButton.isEnabled = false
            oneQuizScrollView.setContentOffset(CGPoint(x: 0, y:0), animated: true)
            oneQuizScrollView.isHidden = true
            var resultText: String = "TRAJANJE: " + String(format: "%.3f",trajanje!)+"\n\n"
            resultText = resultText+"BROJ TOČNIH ODGOVORA: \n" + String(brojTocnih!)+" / " + String(slides.count)
            resultLabel.text = resultText
            resultLabel.isHidden = false
            //print(brojTocnih!)
            
            guard let kvizovi = kvizovi, let trajanje = trajanje, let brojTocnih = brojTocnih else {
                return
            }
            let resultService = ResultService()
            resultService.loginFunction(urlString: "https://iosquiz.herokuapp.com/api/result", quiz_id: (kvizovi[indexpath!.section])[indexpath!.row].id, user_id: (UserDefaults.standard.integer(forKey: "username") ), time: trajanje, no_of_correct: brojTocnih) { _ in }
            
            // /*
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                self.navigationController?.popViewController(animated: true)
            }) // */
        }
    }
}

extension OneQuizViewController : CorrectAnswerProtocol {
    func correctButtonTapped() {
        brojTocnih = brojTocnih! + 1
    }
    
}
    
class OneQuizViewController: UIViewController {
    @IBOutlet weak var oneQuizQuestionView: UIView!
    
   
    @IBOutlet weak var button20: UIButton!
    
    var usernames20: Array<String>=[]
    var scores20: Array<String>=[]
    weak var delegate20 : top20dataProtocol? = nil
    let myViewController = LeaderboardController()
    
    @IBAction func buttonShow20(_ sender: Any) {
        //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.navigationController?.pushViewController(self.myViewController, animated: true)
       // })
    }
    
    
    func fetchData() {
        let urlString="https://iosquiz.herokuapp.com/api/score?quiz_id=5"
        
        let top20service=Top20Service()
        
        top20service.fetchLeaderboard(quiz_id: 4, urlString: urlString) { (podaci) in
            for i in 0...19 {
                if let dict=podaci[i] as? [String:Any] {
                    
                    self.usernames20.append((dict["username"]! as? String)!)
                    self.scores20.append((dict["score"]! as? String)!)
                }
            }
            
            self.delegate20?.setArray20(usernames20: self.usernames20, scores20: self.scores20)
            
        }
    }

    @IBAction func clickStartQuiz(_ sender: UIButton) {
        oneQuizScrollView.isHidden = false
        pocetak = Date.init()
        brojTocnih=0
        startOneQuizButton.isEnabled = false
    }
    
    @IBOutlet weak var oneQuizTitleLabel: UILabel!
    @IBOutlet weak var oneQuizImageView: UIImageView!
    @IBOutlet weak var startOneQuizButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var oneQuizScrollView: UIScrollView!
    var indexpath: IndexPath?
    var kategorije: Array<String>?
    var kvizovi: Array<Array<Quiz>>?
    var slides:[MyQuestionView] = [];
    var trajanje: TimeInterval?
    var pocetak: Date?
    var brojTocnih: Int? = 0
    var brojOdgovorenih: Int? = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserInterface()
        fetchData()
        slides = createSlides()
        setupSlideScrollView(slides: slides)

    }

    func setUpUserInterface(){
        
        resultLabel.isHidden = true
        let kviz: Quiz = (kvizovi![indexpath!.section])[indexpath!.row]
        oneQuizTitleLabel.text = kviz.title
        
        let imageService = ImageService()
        let imageUrl = kviz.image as! String
        
        imageService.fetchImages(urlString: imageUrl) { (image) in
            DispatchQueue.main.async {
                self.oneQuizImageView.image = image
                
            }
            print("image set")
        }
        
       // let questionView = MyQuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 300, height: 350)), quiz: kviz)
      //  oneQuizQuestionView.addSubview(questionView)
    }
    
    func createSlides() -> [MyQuestionView] {
        let kviz: Quiz = (kvizovi![indexpath!.section])[indexpath!.row]
        var slides: Array<MyQuestionView> = []
        for i in 0...(kviz.questions as! Array<Question>).count-1{
            //let questionView1 = MyQuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 300, height: 350)), quiz: kviz, pitanje: (kviz.questions as! Array<Question>)[i])
            
            let questionView1 = MyQuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: view.frame.width, height: view.frame.height)), quiz: kviz, pitanje: (kviz.questions as! Array<Question>)[i])
            
            questionView1.delegate = self
            questionView1.delegate2 = self
            self.delegate20 = myViewController
            slides.append(questionView1)
        }
        return slides
    }
    
    
    
     func setupConstraints(slide: MyQuestionView){
     

     slide.labelQuestionAsked.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
     slide.labelQuestionAsked.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
     //slide.labelQuestionAsked!.autoPinEdge(toSuperviewEdge: .right, withInset: 300 * (CGFloat(slides.count-1))+5)
     //view.frame.width * (CGFloat(slides.count))
    
    
    slide.labelQuestionAsked.numberOfLines = 2
    slide.labelQuestionAsked.adjustsFontSizeToFitWidth = true
    slide.labelQuestionAsked.preferredMaxLayoutWidth = view.frame.width/3*2-50;
        
     slide.buttonAnsw1.autoPinEdge(.top, to: .bottom, of:  slide.labelQuestionAsked, withOffset: 10.0, relation: .equal)
     slide.buttonAnsw1.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
     
     slide.buttonAnsw2.autoPinEdge(.top, to: .bottom, of:  slide.buttonAnsw1, withOffset: 10.0, relation: .equal)
     slide.buttonAnsw2.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
     
     slide.buttonAnsw3.autoPinEdge(.top, to: .bottom, of:  slide.buttonAnsw2, withOffset: 10.0, relation: .equal)
     slide.buttonAnsw3.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
     
     slide.buttonAnsw4.autoPinEdge(.top, to: .bottom, of:  slide.buttonAnsw3, withOffset: 10.0, relation: .equal)
     slide.buttonAnsw4.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        
    slide.buttonAnsw1.autoAlignAxis(.vertical, toSameAxisOf:  slide.labelQuestionAsked)
    slide.buttonAnsw2.autoAlignAxis(.vertical, toSameAxisOf:  slide.labelQuestionAsked)
    slide.buttonAnsw3.autoAlignAxis(.vertical, toSameAxisOf:  slide.labelQuestionAsked)
    slide.buttonAnsw4.autoAlignAxis(.vertical, toSameAxisOf:  slide.labelQuestionAsked)
     }
    
    
    func setupSlideScrollView(slides : [MyQuestionView]) {
        oneQuizScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        oneQuizScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)

        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            self.setupConstraints(slide: slides[i])
            oneQuizScrollView.addSubview(slides[i])
            
        }
        oneQuizScrollView.isHidden = true
        oneQuizScrollView.isScrollEnabled = false
    }


    
}
