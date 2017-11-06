//
//  QuestionOfTheDay.swift
//  QuestionOfTheDay
//
//  Created by student on 11/5/17.
//

import Foundation
@objcMembers
class QuestionOfTheDay: NSObject{
    
    var question : String?
    var answer0 :String?
    var answer1:String?
    var answer2:String?
    // 3  below for future expansion
    var objectId:String?
    var create:NSDate?
    var update:NSDate?
    
    init (question: String?, answer0: String?, answer1: String?, answer2:String?){
        self.question = question
        self.answer0 = answer0
        self.answer1 = answer1
        self.answer2 = answer2
    }
    convenience override init(){
        self.init(question: "What time is it", answer0: "Party Time",answer1: "Hammer Time", answer2: "Game Time")
    }
}