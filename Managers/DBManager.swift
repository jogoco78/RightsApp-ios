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
            
            cursor.close()
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
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return result
    }
    
    func getTagRaised(idQuestion: Int, idAnswer: Int) -> Int {
        var result = 0
        
        let query = "select " + Constants.shared.field_questions_answers_id_tag_raised + " from " + Constants.shared.tableName_questions_answers + " where " + Constants.shared.field_questions_answers_id_question + " = " + String(idQuestion) + " and " + Constants.shared.field_questions_answers_id_answer + " = " + String(idAnswer)
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
                result = Int(cursor.int(forColumnIndex: 0))
            }
            
            cursor.close()
        } catch {
            print("Could not execute the query")
        }
        
        return result
    }
    
    func getSubjectsIDByTag(idTags: [Int], language: String) -> [Int] {
        let particles = getParticlesByTag(idTags: idTags, language: language)
        var idSubjects = [Int]()
        
        for particle in particles {
            idSubjects.append(particle.idSubject)
        }
        
        return idSubjects
    }
    
    func getSubjectsTextByTag(idTags: [Int], language: String) -> [String] {
        let particles = getParticlesByTag(idTags: idTags, language: language)
        var idSubjects = [Int]()
        
        for particle in particles {
            idSubjects.append(particle.idSubject)
        }
        
        return getSubjectbyID(idSubjects: idSubjects, language: language)
    }
    
    func getSubjectbyID(idSubjects: [Int], language: String) -> [String] {
        var results = [String]()
        
        var query = "select * from " + Constants.shared.tableName_subjects + " where " + Constants.shared.field_subjects_id + " in (" + String(idSubjects[0])
        for index in 1..<idSubjects.count {
            query.append("," + String(idSubjects[index]))
        }
        query.append(")")
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
                //results.append(cursor.string(forColumn: Constants.shared.field_subjects_text + language)!)
                results.append(cursor.string(forColumn: Constants.shared.field_subjects_text + "_es")!)
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    func getParticlesByTag(idTags: [Int], language: String) -> [ParticleModel] {
        var results = [Int]()
        
        var query = "select " + Constants.shared.field_particles_tags_idParticle + " from " + Constants.shared.tableName_particles_tags + " where " + Constants.shared.field_particles_tags_idTag + " in (" + String(idTags[0])
        for index in 1..<idTags.count {
            query.append("," + String(idTags[index]))
        }
        query.append(")")
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
                results.append(Int(cursor.int(forColumnIndex: 0)))
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return getParticles(idParticles: results, language: language)
    }
    
    func getParticles(idParticles: [Int], language: String) -> [ParticleModel] {
        var results = [ParticleModel]()
        
        //let languageField = Constants.shared.field_particles_text + "_" + language
        let languageField = Constants.shared.field_particles_text + "_es"
        
        var query = "select * from " + Constants.shared.tableName_particles + " where " + Constants.shared.field_particles_id + " in (" + String(idParticles[0])
        for index in 1..<idParticles.count {
            query.append("," + String(idParticles[index]))
        }
        query.append(")")
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            print("Column count " + String(cursor.columnCount))
            while cursor.next(){
                //print("ID: " + String(cursor.int(forColumnIndex: 5)))
                //print("Text: " + cursor.string(forColumn: languageField)!)
              //  let particle = ParticleModel(Int(cursor.int(forColumnIndex: 0)), cursor.string(forColumn: languageField), cursor.int(forColumnIndex: 5), language)
                results.append(ParticleModel(Int(cursor.int(forColumnIndex: 0)), cursor.string(forColumn: languageField)!, Int(cursor.int(forColumnIndex: 5)), language))
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    // MARK: - Categories, cities and countries
    
    func getCategoriesList(language: String) -> [CategoryModel] {
        var results = [CategoryModel]()
        
        let languageField = Constants.shared.field_categories_text + "_" + language
        
        let query = "select * from " + Constants.shared.tableName_categories
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            print("Column count " + String(cursor.columnCount))
            while cursor.next(){
                results.append(CategoryModel(Int(cursor.int(forColumnIndex: 0)), cursor.string(forColumn: languageField)!, language))
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
}
