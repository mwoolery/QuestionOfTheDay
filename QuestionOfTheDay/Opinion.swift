//
//  Opinion.swift
//  QuestionOfTheDay
//
//  Created by student on 11/5/17.
//

import Foundation
@objcMembers
class Opinion: NSObject{
    var answer: Int
    //for future expansion
    var objectId:String?
    var question:QuestionOfTheDay?
    init(answer:Int, question:QuestionOfTheDay?){
        self.answer = answer
        self.question = question
    }

}
