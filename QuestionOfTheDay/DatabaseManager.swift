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
    
    
    // returns all movies in the database
    func retrieveAllOpinionsAsynchronously() {
        let dispatchQueue = DispatchQueue(label: "clearer", qos:.userInteractive)
        
        dispatchQueue.async {
            
            let numOpinionToFetch = self.dataStoreOpinion?.getObjectCount() as! Int
            let pageSize = 10
            let queryBuilder = DataQueryBuilder()
            var numOpinionFetched = 0
            var allOpinions:[Opinion] = []
            queryBuilder!.setPageSize(Int32(pageSize)).setOffset(0)
            
            while numOpinionFetched < numOpinionToFetch {
                let opinion = self.dataStoreOpinion?.find(queryBuilder) as! [Opinion]
                allOpinions += opinion
                numOpinionFetched += opinion.count
                queryBuilder!.prepareNextPage()
            }
            NotificationCenter.default.post(name:NSNotification.Name(rawValue:"All Opinions Fetched"), object:allOpinions)
        }
        
    }
    
    // returns all movies in the database
    func retrieveAllOpinions() ->[Opinion]{
        
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
    
    
    // retrns all opinions of a specified question
    func retrieveOpinions(of question:QuestionOfTheDay) -> [Opinion] {
        
        let loadRelationsQueryBuilder = LoadRelationsQueryBuilder.of(QuestionOfTheDay.ofClass())
        loadRelationsQueryBuilder!.setRelationName("opinions")
        var allOpinions:[Opinion] = []
        
        while true {
            // retrieve a page of relatedObjects (Movies)
            let relatedObjects = (dataStoreQuestionOfTheDay?.loadRelations(question.objectId, queryBuilder: loadRelationsQueryBuilder))! as! [Opinion]
            if relatedObjects.count == 0 { // no more Movies? we're out of here.
                break
            }
            allOpinions += relatedObjects
            
            loadRelationsQueryBuilder!.prepareNextPage() // move on to the next page
        }
        
        return allOpinions
    }
    
    
    // returns all directors
    func retrieveAllQuestionOfTheDays() ->[QuestionOfTheDay]{
        
        let numQuestionOfTheDayToFetch = dataStoreQuestionOfTheDay?.getObjectCount() as! Int
        let pageSize = 10
        let queryBuilder = DataQueryBuilder()
        var numQuestionOfTheDayFetched = 0
        var allQuestionOfTheDay:[QuestionOfTheDay] = []
        queryBuilder!.setPageSize(Int32(pageSize)).setOffset(0)
        
        while(numQuestionOfTheDayFetched < numQuestionOfTheDayToFetch) {
            let questionOfTheDay = self.dataStoreQuestionOfTheDay?.find(queryBuilder) as! [QuestionOfTheDay]
            allQuestionOfTheDay += questionOfTheDay
            numQuestionOfTheDayFetched += questionOfTheDay.count
            queryBuilder!.prepareNextPage()
        }
        return allQuestionOfTheDay
    }
    
    func retrieveAllQuestionOfTheDaysAsynchronously() -> Void {
        let dispatchQueue = DispatchQueue(label: "clearer", qos:.userInteractive)
        
        dispatchQueue.async {
            let numQuestionOfTheDayToFetch = self.dataStoreQuestionOfTheDay?.getObjectCount() as! Int
            let pageSize = 10
            let queryBuilder = DataQueryBuilder()
            var numQuestionOfTheDayFetched = 0
            var allQuestionOfTheDay:[QuestionOfTheDay] = []
            queryBuilder!.setPageSize(Int32(pageSize)).setOffset(0)
            
            while(numQuestionOfTheDayFetched < numQuestionOfTheDayToFetch) {
                let questionOfTheDay = self.dataStoreQuestionOfTheDay?.find(queryBuilder) as! [QuestionOfTheDay]
                allQuestionOfTheDay += questionOfTheDay
                numQuestionOfTheDayFetched += questionOfTheDay.count
                queryBuilder!.prepareNextPage()
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"All Directors Fetched"), object: allQuestionOfTheDay)
        }
    }
    
    // clears the entire database asynchronously
    func clearDatabase(){
        Types.tryblock(
            { ()->Void in
                let dispatchQueue = DispatchQueue(label: "clearer", qos:.utility)
                dispatchQueue.async {  self.clearDatabaseSynchronously() }
        },catchblock:{(fault)->Void in print("Problem clearing database: \(String(describing: fault))")}
        )
    }
    
    // clears the database
    func clearDatabaseSynchronously(){
        // clear movies first
        let allMovies = self.retrieveAllMovies()
        for movie in allMovies {
            print("Removing \(movie)")
            let dateStampRemoved = self.dataStoreMovie?.remove(movie)
            print("date stamped removed: \(String(describing: dateStampRemoved))")
        }
        
        let allDirectors = self.retrieveAllDirectors()
        print(allDirectors)
        for director in allDirectors {
            print("Removing director \(director)")
            let dateStampRemoved = self.dataStoreDirector?.remove(director)
            print("date stamped removed: \(String(describing: dateStampRemoved))")
        }
    }
    
    // populates the entire database asynchronously
    func populateDatabase(){
        
        let dispatchQueue = DispatchQueue(label: "clearer", qos:.utility)
        dispatchQueue.async {
            Types.tryblock(
                { ()->Void in
                    self.populateDatabaseSynchronously()
            },
                catchblock:{(fault)->Void in print("We had an owie: \(String(describing:fault))")}
            )
        }
    }
    
    
    // populates the entire database
    func populateDatabaseSynchronously(){
        
        // save all the directors (non-blocking)
        for (director, movies) in DatabaseManager.portfolio {
            let savedDirector = dataStoreDirector?.save(director) as! Director // save a Director
            var savedMovies:[String] = []
            
            for movie in movies {
                let savedMovie = dataStoreMovie?.save(movie) as! Movie // save each of their movies
                
                savedMovies.append(savedMovie.objectId!) // gather the array of objectIds
                let _ = dataStoreMovie?.setRelation("director:Director:1", // each movie has 1 director
                    parentObjectId:savedMovie.objectId,
                    childObjects:[savedDirector.objectId ?? ""])
            }
            
            let _ = dataStoreDirector?.addRelation("movies:Movie:n",
                                                   parentObjectId: savedDirector.objectId,
                                                   childObjects: savedMovies)
        }
    }
    
}
