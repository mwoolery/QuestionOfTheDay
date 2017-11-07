//
//  Opinion.swift
//  QuestionOfTheDay
//  Christopher List and Matthew Woolery
//  Created by student on 11/5/17.
//

//  This portion was done by Matthew Wooler

import Foundation

@objcMembers

//Opinion class for the user answer

class Opinion: NSObject {
    
    var answer: Int = 0
    
//    //for future expansion
//    var objectId:String?
//
    init(answer:Int){
     self.answer = answer
    }
    //Initializer
    override init() {
        super.init()
        answer = 0
    }

}
