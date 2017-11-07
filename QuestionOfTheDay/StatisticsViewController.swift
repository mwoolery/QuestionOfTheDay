//
//  StatisticsViewController.swift
//  QuestionOfTheDay
//
//  Created by student on 11/5/17.
//

import UIKit

class StatisticsViewController: UIViewController {
    let statistician:Statistician = Statistician()
    @IBOutlet weak var questionLBL: UILabel!
    @IBOutlet weak var answer0LBL: UILabel!
    @IBOutlet weak var answer1LBL: UILabel!
    @IBOutlet weak var answer2LBL: UILabel!
    @IBOutlet weak var stats0LBL: UILabel!
    @IBOutlet weak var stats1LBL: UILabel!
    @IBOutlet weak var stats2LBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var answer:[Double] = statistician.findPercentage()
        stats0LBL.text = String(format: "%.1f%%",answer[0])
        stats1LBL.text = String(format: "%.1f%%",answer[1])
        stats2LBL.text = String(format: "%.1f%%",answer[2])
        questionLBL?.text = statistician.fetchQuestionOfTheDay().question
        answer0LBL?.text = statistician.fetchQuestionOfTheDay().answer0
        answer1LBL?.text = statistician.fetchQuestionOfTheDay().answer1
        answer2LBL?.text = statistician.fetchQuestionOfTheDay().answer2
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
