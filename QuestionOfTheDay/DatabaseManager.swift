//
//  DatabaseManager.swift
//  QuestionOfTheDay
//
//  Created by student on 11/6/17.
//

import Foundation

let databaseManager:DatabaseManager = DatabaseManager()

class DatabaseManager {
    let APPLICATION_ID = "4D3FD244-8F00-858C-FF1B-B0DB5F95C000"
    let API_KEY = "44D4173F-E674-F658-FF51-5334102EB900"
    let SERVER_URL = "https://api.backendless.com"
    let backendless = Backendless.sharedInstance()!
    var dataStoreQuestionOfTheDay: IDataStore!
    var dataStoreOpinion: IDataStore!
    
    init(){
        backendless.hostURL = SERVER_URL
        backendless.initApp(APPLICATION_ID, apiKey: API_KEY)
        dataStoreQuestionOfTheDay = backendless.data.of(QuestionOfTheDay.ofClass())
        dataStoreOpinion = backendless.data.of(Opinion.ofClass())
        
    }
    // finds question with given name - nil if not in table
    func findQuestionOfTheDay(named:String?) -> QuestionOfTheDay? {
        if named == nil {
            return nil
        }
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause("question LIKE '%\(named!)%'")
        if let questions = self.dataStoreQuestionOfTheDay?.find(queryBuilder){
            return questions.count > 0 ? questions[0] as? QuestionOfTheDay : nil
        }else {
            return nil
        }
    }
    
    
}
