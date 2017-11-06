//
//  Statistician.swift
//  QuestionOfTheDay
//
//  Created by student on 11/5/17.
//

import Foundation


class Statistician {
    
    let APPLICATION_ID = "46A8800E-B115-4622-FFDA-7ABE14BF0000"
    let API_KEY = "AE8B888C-1B6C-CC3C-FF18-BF35522E0100"
    let SERVER_URL = "https://api.backendless.com"
    let backendless = Backendless.sharedInstance()!
    var dataStoreQuestionOfTheDay: IDataStore!
    var dataStoreOpinion: IDataStore!
    
    
    init(){
        backendless.hostURL = SERVER_URL
        backendless.initApp(APPLICATION_ID, apiKey: API_KEY)
        
        
       
//        dataStoreQuestionOfTheDay.find(byId: "4AC48C78-0767-14B3-FF66-0235190A8B00", response: ((QuestionOfTheDay?) -> Void)!, error:((Fault?) ->Void)!)
        
        
    }
    
    
    func findPercentage() -> [Double]{
        let opinions:[Opinion] = retrieveAllOpinions()
        var answer0:Int = 0
        var answer1:Int = 0
        var answer2:Int = 0
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
        percentages.append(Double(answer0/opinions.count)*100)
        percentages.append(Double(answer1/opinions.count)*100)
        percentages.append(Double(answer2/opinions.count)*100)
        return percentages
        
    }
    
    func fetchQuestionOfTheDay() -> QuestionOfTheDay{
        
        dataStoreQuestionOfTheDay = backendless.data.of(QuestionOfTheDay.ofClass())
        let dataQuestionOfTheDayObject = dataStoreQuestionOfTheDay.find(byId: "7B353020-D29B-5EBC-FFDC-60D3DEACF300") as! QuestionOfTheDay

        return dataQuestionOfTheDayObject
    }
    func saveOpinion(opinion: Opinion){
        dataStoreOpinion = backendless.data.of(Opinion.ofClass())
        _ = dataStoreOpinion?.save(opinion) as! Opinion
    }
    
    func retrieveAllOpinions() ->[Opinion]{
        dataStoreOpinion = backendless.data.of(Opinion.ofClass())
        let numMoviesToFetch = dataStoreOpinion?.getObjectCount() as! Int
        let pageSize = 10
        let queryBuilder = DataQueryBuilder()
        var numOpinionFetched = 0
        var allOpinions:[Opinion] = []
        queryBuilder!.setPageSize(Int32(pageSize)).setOffset(0)
        
        while numOpinionFetched < numMoviesToFetch {
            let opinions = self.dataStoreOpinion?.find(queryBuilder) as! [Opinion]
            allOpinions += opinions
            numOpinionFetched += opinions.count
            queryBuilder!.prepareNextPage()
                }
                return allOpinions
            }

}
