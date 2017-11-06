//
//  Statistician.swift
//  QuestionOfTheDay
//
//  Created by student on 11/5/17.
//

import Foundation

class Statistician {
    
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
    
    
    func findPercentage(){
        
    }
    
    func fetchQuestionOfTheDay() -> QuestionOfTheDay{
        let numQuestionOfTheDayToFetch = dataStoreQuestionOfTheDay?.getObjectCount() as! Int
        let pageSize = 10
        let queryBuilder = DataQueryBuilder()
        var numQuestionOfTheDayFetched = 0
        var allQuestionOfTheDay:[QuestionOfTheDay] = []
        queryBuilder!.setPageSize(Int32(pageSize)).setOffset(0)
        
        while(numQuestionOfTheDayFetched < numQuestionOfTheDayToFetch) {
            let question = self.dataStoreQuestionOfTheDay?.find(queryBuilder) as! [QuestionOfTheDay]
            allQuestionOfTheDay += question
            numQuestionOfTheDayFetched += question.count
            queryBuilder!.prepareNextPage()
        }
        // get only the first element in the array since currently the admin is changing the question daily
        // in the future though they could use this and return an array and get questions for multiple days and
        // then just do a query on the resulting set.
        return allQuestionOfTheDay[0]
    }
    func saveOpinion(){
        
    }

}
