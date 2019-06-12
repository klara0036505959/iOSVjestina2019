//
//  MyViewController.swift
//  QuizGame
//
//  Created by Five Admin on 4/2/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit
//import Reachability

class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func buttonTAP(_ sender: Any) {
        fetchQuiz()
    }
    
    
    @IBOutlet weak var QuizTableView: UITableView!
    
    @IBOutlet weak var questionViewContainer: UIView!
    @IBOutlet weak var buttonDohvati: UIButton!
    @IBOutlet weak var labelFunFact: UILabel!
    @IBOutlet weak var labelFailed: UILabel!
    
    @IBOutlet weak var imagePickedQuiz: UIImageView!
    @IBOutlet weak var labelTitlePickedQuiz: UILabel!
    
    var reachability: Reachability?
    
    
    var kategorije: Array<String> = ["SPORTS", "SCIENCE"]
    var cells: Array<Array<Quiz>>=[]
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oneQuizController = OneQuizViewController()
        oneQuizController.indexpath = indexPath
        oneQuizController.kategorije = kategorije
        oneQuizController.kvizovi = cells
        //self.cells.removeAll()
        self.navigationController?.pushViewController(oneQuizController, animated: true)
        
    }
    
    
    func numberOfSections (in tableView: UITableView) -> Int {
     return kategorije.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
        label.text = kategorije[section]
        
        var categ = Category.UNKNOWN
        switch kategorije[section] {
        case "SCIENCE":
            categ = Category.SCIENCE
        case "SPORTS":
            categ = Category.SPORTS
        default:
            categ = Category.UNKNOWN
        }
        view.backgroundColor = categ.color
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let quizService = QuizService()
        var broj = 1
        if section == 0 {broj = 2}
        quizService.fetchQuizes(urlString: urlString) {(dict) in
            DispatchQueue.main.async {
                if let dict = dict {
                    if let pickedQuiz = (dict.data as? Array<Quiz>){
                        broj=pickedQuiz.count
                        //print(broj)
                    }
                }else{broj = 0}
           }
        }
        return broj
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTitleTableViewCell", for: indexPath) as! QuizTitleTableViewCell
        
        var celije: Array<Array<Quiz>> = []
       
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let quizService = QuizService()
        
        self.reachability=Reachability.init()
        if (self.reachability?.connection) == .none {
            print("Nema interneta")
            let CDService = CoreDataService()
            let quizzes: Array<Quiz> = CDService.getQuizzesFromCD()
            print(quizzes.count)
            
            
            self.labelFailed.isHidden = true
            
            //var celije: Array<Array<Quiz>> = []
            var sportski_kvizovi: Array<Quiz> = []
            var science_kvizovi: Array<Quiz> = []
                
                for quiz in quizzes{
                    if quiz.category == "SCIENCE"{
                        science_kvizovi.append(quiz)
                    }
                    else{
                        sportski_kvizovi.append(quiz)
                    }
                }
                celije.append(sportski_kvizovi);
                celije.append(science_kvizovi);
                self.cells.removeAll()
                self.cells.append(sportski_kvizovi);
                self.cells.append(science_kvizovi);
                
                
                let thiscell:Quiz = (celije[indexPath.section])[indexPath.row]
                
                var razina: String=""
                for _ in 0...thiscell.level{
                    razina+="*"
                }
                cell.quizTitleLabelCell.text = thiscell.title
                cell.quizLevelLabelCell.text = razina
                cell.quizDescLabelCell.text = thiscell.description as? String
                
                self.fetchImage(pickedQuiz: thiscell, image: cell.quizCellImage)
        }
        
        else{
            quizService.fetchQuizes(urlString: urlString) { (dict) in
                DispatchQueue.main.async {
                    if let dict = dict {
                        self.labelFailed.isHidden = true
                        var sportski_kvizovi: Array<Quiz> = []
                        var science_kvizovi: Array<Quiz> = []
                        if let pickedQuiz = (dict.data as? Array<Quiz>){
                            
                            for quiz in pickedQuiz{
                                if quiz.category == "SCIENCE"{
                                    science_kvizovi.append(quiz)
                                }
                                else{
                                    sportski_kvizovi.append(quiz)
                                }
                            }
                            celije.append(sportski_kvizovi);
                            celije.append(science_kvizovi);
                            self.cells.removeAll()
                            self.cells.append(sportski_kvizovi);
                            self.cells.append(science_kvizovi);
                            
                            let thiscell:Quiz = (celije[indexPath.section])[indexPath.row]
                            
                            let CDService = CoreDataService()
                            var oneElemArray: Array<Quiz> = []
                            oneElemArray.append(thiscell)
                            //print(thiscell.questions)
                            CDService.saveToMemory(oneElemArray)
                            
                            var razina: String=""
                            for _ in 0...thiscell.level{
                                razina+="*"
                            }
                            cell.quizTitleLabelCell.text = thiscell.title
                            cell.quizLevelLabelCell.text = razina
                            cell.quizDescLabelCell.text = thiscell.description as? String
                            
                            self.fetchImage(pickedQuiz: thiscell, image: cell.quizCellImage)
                            
                        }else {self.imagePickedQuiz.image = UIImage(named: "quizPic.png")}
                    } else{
                        self.labelFailed.isHidden = false
                    }
                }
            }
        }
        return cell
    }
    
    
    func fetchQuiz() {

        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let quizService = QuizService()
        
        quizService.fetchQuizes(urlString: urlString) { (dict) in
            DispatchQueue.main.async {
                if let dict = dict {
                    self.labelFailed.isHidden = true
                    var kolekcija: Array<String> = []
                    for elem in dict.data as! Array<Quiz>{
                        for bla in elem.questions as! Array<Question>{
                            kolekcija.append(bla.question)
                        }
                    }
                    let broj = kolekcija.filter({e in e.contains("NBA")}).count
                    self.labelFunFact.text="FUN FACT: Riječ NBA se u pitanjima pojavljuje \(broj) puta"
                    /*
                    if let pickedQuiz = (dict.data as? Array<Quiz>)?.randomElement(){
                        
                        self.labelTitlePickedQuiz.text = pickedQuiz.title
                        
                        var categ = Category.UNKNOWN
                        switch pickedQuiz.category {
                        case "SCIENCE":
                            categ = Category.SCIENCE
                        case "SPORTS":
                            categ = Category.SPORTS
                        default:
                            categ = Category.UNKNOWN
                        }
                        self.labelTitlePickedQuiz.backgroundColor=categ.color
                        self.imagePickedQuiz.backgroundColor=categ.color
                        
                        self.fetchImage(pickedQuiz: pickedQuiz, image: self.imagePickedQuiz)
                        
                        self.imagePickedQuiz.isHidden = false
                        self.labelTitlePickedQuiz.isHidden = false
                        
                        
                        //self.addCustomView(pickedQuiz: pickedQuiz)
 
                    }else{
                        self.imagePickedQuiz.image = UIImage(named: "quizPic.png")
                    }
                    //return dict.data as? Array<Quiz>
*/
                } else{
                    self.labelFailed.isHidden = false
                }
            }
        }
        
    }
    
    func fetchImage(pickedQuiz: Quiz, image: UIImageView){

        //"https://www.artsyeinstein.com/wp-content/uploads/2017/10/AED-20150408_061541_148-1.jpg"
        //pickedQuiz.image as? String
        if let imageUrl: String = pickedQuiz.image as? String{
            
            let imageService = ImageService()
            
            imageService.fetchImages(urlString: imageUrl) { (image2) in
                DispatchQueue.main.async {
                    image.image = image2
                    
                }
                print("image set")
            }
        }
        
    }
    
    
    /*
    func addCustomView(pickedQuiz: Quiz) {
        let questionView = MyQuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 300, height: 350)), quiz: pickedQuiz)
        questionViewContainer.addSubview(questionView)
    }
    
*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imagePickedQuiz.image = UIImage(named: "quizPic.png")
        
      QuizTableView.register(UINib(nibName: "QuizTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "QuizTitleTableViewCell")
        
        self.QuizTableView.delegate = self
        self.QuizTableView.dataSource = self
        
        

    }

}
