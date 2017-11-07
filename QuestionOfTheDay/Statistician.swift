//
//  Statistician.swift
//  QuestionOfTheDay
//  Christopher List and Matthew Woolery
//  Created by student on 11/5/17.
//

//  This portion was done by both Christopher List and Matthew Woolery.
//  Matthew typed the code in this section but both shared knowledge on what needed to
//  be done and how to do it.

import Foundation

//Statistician class has functions to connect to backendless

class Statistician {
    
    //Create variables used to connect to backendless
    
    let APPLICATION_ID = "46A8800E-B115-4622-FFDA-7ABE14BF0000"
    let API_KEY = "AE8B888C-1B6C-CC3C-FF18-BF35522E0100"
    let SERVER_URL = "https://api.backendless.com"
    let backendless = Backendless.sharedInstance()!
    var dataStoreQuestionOfTheDay: IDataStore!
    var dataStoreOpinion: IDataStore!
    
    //Initialization
    init(){
        backendless.hostURL = SERVER_URL
        backendless.initApp(APPLICATION_ID, apiKey: API_KEY)
        
    }
    
    //Function that calculates the number of votes for each answer and
    //returns an array of doubles that are the percentage of each answer
    //chosen.
    
    func findPercentage() -> [Double]{
        let opinions:[Opinion] = retrieveAllOpinions()
        var answer0:Double = 0.0
        var answer1:Double = 0.0
        var answer2:Double = 0.0
        var percentages:[Double] = []
        for o in opinions{
            if o.answer == 0{
                answer0 = answer0 + 1
            }
            
            if o.answer == 1{
                answer1 = answer1 + 1
            }
            
            if o.answer == 2{
                answer2 = answer2 + 1
            }
            
        }
        percentages.append(Double(answer0/Double(opinions.count))*100.0)
        percentages.append(Double(answer1/Double(opinions.count))*100.0)
        percentages.append(Double(answer2/Double(opinions.count))*100.0)
        return percentages
        
    }
    
    //This function grabs the information from the QuestionOfTheDay table in backendless
    //using the id and stores it as a QuestionOfTheDay object
    
    func fetchQuestionOfTheDay() -> QuestionOfTheDay{
        
        dataStoreQuestionOfTheDay = backendless.data.of(QuestionOfTheDay.ofClass())
        let dataQuestionOfTheDayObject = dataStoreQuestionOfTheDay.find(byId: "7B353020-D29B-5EBC-FFDC-60D3DEACF300") as! QuestionOfTheDay

        return dataQuestionOfTheDayObject
    }
    
    //This will send the user's answer to backendless, storing it.
    
    func saveOpinion(opinion: Opinion){
        dataStoreOpinion = backendless.data.of(Opinion.ofClass())
        _ = dataStoreOpinion?.save(opinion) as! Opinion
    }
    
    //This function retrieves all opinions in the backendless database and stores it as
    //an array of Opinions.
    
    func retrieveAllOpinions() ->[Opinion]{
        dataStoreOpinion = backendless.data.of(Opinion.ofClass())
        let numOpinionsToFetch = dataStoreOpinion?.getObjectCount() as! Int
        let pageSize = 10
        let queryBuilder = DataQueryBuilder()
        var numOpinionFetched = 0
        var allOpinions:[Opinion] = []
        queryBuilder!.setPageSize(Int32(pageSize)).setOffset(0)
        
        while numOpinionFetched < numOpinionsToFetch {
            let opinions = self.dataStoreOpinion?.find(queryBuilder) as! [Opinion]
            allOpinions += opinions
            numOpinionFetched += opinions.count
            queryBuilder!.prepareNextPage()
                }
                return allOpinions
            }

}
