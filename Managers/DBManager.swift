//
//  DBManager.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 12/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class DBManager: NSObject {
    
    static let shared: DBManager = DBManager()
    let databaseFileName = Constants.shared.databaseName
    var pathToDatabase: String!
    var database: FMDatabase!
    
    override init() {
        super.init()
        
        //Copies the database if it does not exists in the documents folder
        copyDatabaseIfNeeded()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    //Copies the database if it does not exists in the documents folder
    private func copyDatabaseIfNeeded() {
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard documentsUrl.count != 0 else {
            return
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("\(databaseFileName)")
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            let databaseInMainBundleURL = Bundle.main.resourceURL?.appendingPathComponent("\(databaseFileName)")
            
            do {
                try fileManager.copyItem(atPath: (databaseInMainBundleURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
    }
    
    //Opens the data if it is not open yet
    func openDatabase() -> Bool {
        var result: Bool
        
        result = false
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            result = database.open()
        }
        
        return result
    }
    /*
    // MARK: - Questions and answers
     */
    
    /* Returns the question text given by parameter */
    func getQuestionText(id_question: Int, language: String) -> String{
        return getQuestionsText(id_questions: [id_question], language: language)[0]
    }
    
    /* Return an array of text for the ids given by parameter */
    func getQuestionsText(id_questions: [Int], language: String) -> [String]{
        var results = [String]() //empty array string
        
        var query = "SELECT * FROM " + Constants.shared.tableName_questions + " WHERE "
        query = query + Constants.shared.field_questions_id + " IN (" + String(id_questions[0])
        
        for index in 1..<id_questions.count{
            query = query + "," + String(id_questions[index])
        }
        query = query + ")"
        
        print(query)
        
        do {
            var result = ""
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
                switch(language){
                case "en":
                    result = cursor.string(forColumnIndex: 2)!
                    break
                case "es":
                    result = cursor.string(forColumnIndex: 1)!
                    break
                default:
                    //do by default
                    print("The specified language not match")
                }
                results.append(result)
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    /* Returns the answers related to a given question */
    func getAnswersForQuestion(idQuestion: Int, language: String) -> [AnswerModel]{
        var results = [AnswerModel]()
        
        let query = "select " + Constants.shared.field_answers_id + ", text_" + language + " from " + Constants.shared.tableName_answers + " inner join " + Constants.shared.tableName_questions_answers + " on " + Constants.shared.field_questions_answers_id_answer + " = " + Constants.shared.field_answers_id + " where " + Constants.shared.field_questions_answers_id_question + " = " + String(idQuestion)
        //select id,text_es from answers inner join questions_answers on questions_answers.id_answer = answers.id where questions_answers.id_question = 4
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
                results.append(AnswerModel(Int(cursor.int(forColumnIndex: 0)), cursor.string(forColumnIndex: 1)!, language))
            }
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    func getNextQuestionID(idQuestion: Int, idAnswer: Int) -> Int{
        var result = 0
        
        let query = "select " + Constants.shared.field_questions_answers_id_next_question + " from " + Constants.shared.tableName_questions_answers + " where " + Constants.shared.field_questions_answers_id_question + " = " + String(idQuestion) + " and " + Constants.shared.field_questions_answers_id_answer + " = " + String(idAnswer)
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
                result = Int(cursor.int(forColumnIndex: 0))
            }
        }catch {
            print("Could not execute the query")
        }
        
        return result
    }
}
