//
//  Opinion.swift
//  QuestionOfTheDay
//
//  Created by student on 11/5/17.
//

import Foundation
@objcMembers
class Opinion: NSObject {
    
    var answer: Int = 0
    //for future expansion
    var objectId:String?
 
 
    init(answer:Int){
     self.answer = answer
    }
    override init(){
        super.init()
        answer = 0
    }

}
