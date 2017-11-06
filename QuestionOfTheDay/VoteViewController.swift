//
//  VoteViewController.swift
//  QuestionOfTheDay
//
//  Created by student on 11/5/17.
//

import UIKit

class VoteViewController: UIViewController {
    let statistician:Statistician = Statistician()
    @IBOutlet weak var questionLBL: UILabel!
    @IBOutlet weak var answer0LBL: UILabel!
    @IBOutlet weak var answer1LBL: UILabel!
    @IBOutlet weak var answer2LBL: UILabel!
    var questionOfTheDay:QuestionOfTheDay!
    
    
    @IBAction func ABTN(_ sender: Any) {
    }
    @IBAction func BBTN(_ sender: Any) {
    }
    @IBAction func CBTN(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
       
        questionLBL?.text = statistician.fetchQuestionOfTheDay().question
        answer0LBL?.text = statistician.fetchQuestionOfTheDay().answer0
        answer1LBL?.text = statistician.fetchQuestionOfTheDay().answer1
        answer2LBL?.text = statistician.fetchQuestionOfTheDay().answer2
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        questionOfTheDay = statistician.fetchQuestionOfTheDay()
       
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
