//
//  StatisticsViewController.swift
//  QuestionOfTheDay
//  Christopher List and Matthew Woolery
//  Created by student on 11/5/17.
//

//  This portion was done mostly by Christopher List
//  Matt made and connected the labels,
//  Chris did constraints

import UIKit

//View controller for the Statistics tab view

class StatisticsViewController: UIViewController {
    
    let statistician:Statistician = Statistician()
    
    //Connection of all the labels
    
    @IBOutlet weak var questionLBL: UILabel!
    @IBOutlet weak var answer0LBL: UILabel!
    @IBOutlet weak var answer1LBL: UILabel!
    @IBOutlet weak var answer2LBL: UILabel!
    @IBOutlet weak var stats0LBL: UILabel!
    @IBOutlet weak var stats1LBL: UILabel!
    @IBOutlet weak var stats2LBL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewWillAppear(_ animated: Bool) {
            
        //Create the array that stores the percentage of each answer
        
        var answer:[Double] = statistician.findPercentage()
        
        //Assigns the stored percentages from the array to their corrosponding label
        //and formats the string to one decimal place followed by a % sign
        
        stats0LBL.text = String(format: "%.1f%%",answer[0])
        stats1LBL.text = String(format: "%.1f%%",answer[1])
        stats2LBL.text = String(format: "%.1f%%",answer[2])
        
        //Assigns the question and answers on the Statistics view as well
        
        questionLBL?.text = statistician.fetchQuestionOfTheDay().question
        answer0LBL?.text = statistician.fetchQuestionOfTheDay().answer0
        answer1LBL?.text = statistician.fetchQuestionOfTheDay().answer1
        answer2LBL?.text = statistician.fetchQuestionOfTheDay().answer2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
