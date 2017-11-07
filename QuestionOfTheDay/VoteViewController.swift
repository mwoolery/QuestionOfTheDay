//
//  VoteViewController.swift
//  QuestionOfTheDay
//  Christopher List and Matthew Woolery
//  Created by student on 11/5/17.
//

//  This portion was done mostly by Matthew Woolery
//  Matt made and connected the labels and buttons,
//  Chris did constraints

import UIKit

//View controller for the Vote! tab view

class VoteViewController: UIViewController {
    let statistician:Statistician = Statistician()
    
    //Connection of all the labels
    
    @IBOutlet weak var questionLBL: UILabel!
    @IBOutlet weak var answer0LBL: UILabel!
    @IBOutlet weak var answer1LBL: UILabel!
    @IBOutlet weak var answer2LBL: UILabel!
    var questionOfTheDay:QuestionOfTheDay!
    
    //Connection of the buttons as well as runs the function that
    //saves the chosen answer to the database
    
    @IBAction func ABTN(_ sender: Any) {
        let opinion:Opinion = Opinion(answer: 0)
        statistician.saveOpinion(opinion: opinion)
    }
    @IBAction func BBTN(_ sender: Any) {
         let opinion:Opinion = Opinion(answer: 1)
        statistician.saveOpinion(opinion: opinion)
    }
    @IBAction func CBTN(_ sender: Any) {
         let opinion:Opinion = Opinion(answer: 2)
        statistician.saveOpinion(opinion: opinion)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets the question and answers from the database to their corrosponding labels
        
        questionLBL?.text = statistician.fetchQuestionOfTheDay().question
        answer0LBL?.text = statistician.fetchQuestionOfTheDay().answer0
        answer1LBL?.text = statistician.fetchQuestionOfTheDay().answer1
        answer2LBL?.text = statistician.fetchQuestionOfTheDay().answer2
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //Just in case they want to see the new question at midnight without restarting the app.
        
        questionOfTheDay = statistician.fetchQuestionOfTheDay()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
