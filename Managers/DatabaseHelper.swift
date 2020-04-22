//
//  DBManager.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 12/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class DatabaseHelper: NSObject {
    
    static let shared: DatabaseHelper = DatabaseHelper()
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
        
        let databaseInMainBundleURL = Bundle.main.resourceURL?.appendingPathComponent("\(databaseFileName)")
        
        do {
            if fileManager.fileExists(atPath: finalDatabaseURL.path){
                try fileManager.removeItem(atPath: finalDatabaseURL.path)
            }
            try fileManager.copyItem(atPath: (databaseInMainBundleURL?.path)!, toPath: finalDatabaseURL.path)
        } catch let error as NSError {
            print("Couldn't copy file to final location! Error:\(error.description)")
        }
    }
    
    //Opens the database if it is not open yet
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
    
    // Returns the question text given by parameter
    func getQuestionText(id_question: Int, language: String) -> String{
        return getQuestionsText(id_questions: [id_question], language: language)[0]
    }
    
    // Return an array of text for the ids given by parameter
    func getQuestionsText(id_questions: [Int], language: String) -> [String]{
        var results = [String]() //empty array string
        let languageField = Constants.shared.field_questions_text + "_" + language
        
        var query = "SELECT * FROM " + Constants.shared.tableName_questions + " WHERE "
        query = query + Constants.shared.field_questions_id + " IN (" + String(id_questions[0])
        
        for index in 1..<id_questions.count{
            query = query + "," + String(id_questions[index])
        }
        query = query + ")"
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
                results.append(cursor.string(forColumn: languageField)!)
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
    
    /*
     // MARK: - Tags
     */
    
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
    
     // MARK: - Subjects and particles
    
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
                results.append(cursor.string(forColumn: Constants.shared.field_subjects_text + "_" + language)!)
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    func getParticlesByTag(idTags: [Int], language: String) -> [ParticleModel] {
        var results = [Int]()
        //TODO: Adapt to the new database
        /*String query = "SELECT DISTINCT pm." + DBContract.Particles_MainTags.COLUMN_NAME_ID_PARTICLE +  " * FROM " + DBContract.Particles_MainTags.TABLE_NAME + " pm INNER JOIN " + DBContract.Particles_residenceTags.TABLE_NAME + " pr ON pm." + DBContract.Particles_MainTags.COLUMN_NAME_ID_PARTICLE + "=pr." + DBContract.Particles_residenceTags.COLUMN_NAME_ID_PARTICLE;*/
        
        var select = "select distinct pm." + Constants.shared.field_particles_mainTags_idParticle + " from " + Constants.shared.tableName_particlesMain_tags + " pm "
        var innerJoin = "inner join " + Constants.shared.tableName_particlesResidence_tags + " pr on pm." + Constants.shared.field_particles_mainTags_idParticle + "=pr." + Constants.shared.field_particles_residenceTags_idParticle
        
        
        
        /*var query = "select " + Constants.shared.field_particles_tags_idParticle + " from " + Constants.shared.tableName_particles_tags + " where " + Constants.shared.field_particles_tags_idTag + " in (" + String(idTags[0])
        for index in 1..<idTags.count {
            query.append("," + String(idTags[index]))
        }
        query.append(")")*/
        
        var query = select + innerJoin
        
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
        
        let languageField = Constants.shared.field_particles_text + "_" + language
        
        var query = "select * from " + Constants.shared.tableName_particles + " where " + Constants.shared.field_particles_id + " in (" + String(idParticles[0])
        for index in 1..<idParticles.count {
            query.append("," + String(idParticles[index]))
        }
        query.append(")")
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
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
            
            while cursor.next(){
                results.append(CategoryModel(Int(cursor.int(forColumnIndex: 0)), cursor.string(forColumn: languageField)!, language))
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    func getCitiesList(idCities: [Int]!, language: String) -> [CityModel]{
        var results = [CityModel]()
        
        let languageField = Constants.shared.field_cities_cityName + "_" + language
        
        var query = "select * from " + Constants.shared.tableName_cities
        
        if idCities != nil && !idCities.isEmpty {
            query = query + " where " + Constants.shared.field_cities_id + " in (" + String(idCities[0])
            for index in 1..<idCities.count {
                query = query + "," + String(idCities[index])
            }
            query = query + ")"
        }
        
        query = query + " order by " + languageField
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            
            while cursor.next(){
                results.append(CityModel(Int(cursor.int(forColumnIndex: 0)), cursor.string(forColumn: languageField)!, Int(cursor.int(forColumnIndex: 5)), language))
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    func getCitiesFromCountry(idCountry: Int, language: String) -> [CityModel] {
        var results = [CityModel]()
        
        let languageField = Constants.shared.field_cities_cityName + "_" + language
        
        let query = "select * from " + Constants.shared.tableName_cities + " where " + Constants.shared.field_cities_idCountry + " = " + String(idCountry) + " order by " + languageField
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            
            while cursor.next(){
                results.append(CityModel(Int(cursor.int(forColumnIndex: 0)), cursor.string(forColumn: languageField)!, Int(cursor.int(forColumnIndex: 5)), language))
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    /// Returns the cities where institutions from the given category are available
    ///
    /// - Warning: No nil checking
    /// - parameter idCategory: ID of the category
    /// - parameter language: Language to get the city name
    /// - returns: an array with CityModels
    func getCitiesFromCategories(idCategory: Int, language: String) -> [CityModel] {
        var results = [CityModel]()
        
        let languageField = Constants.shared.field_cities_cityName + "_" + language
        
        let select = "select distinct c.* from " + Constants.shared.tableName_entities + " e," + Constants.shared.tableName_cities + " c "
        let qwhere = "where e." + Constants.shared.field_entities_id_category + " = " + String(idCategory)
        let and = " and e." + Constants.shared.field_entities_id_city + " = c." + Constants.shared.field_cities_id
        let order = " order by " + languageField
        
        let query = select + qwhere + and + order
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            
            while cursor.next(){
                results.append(CityModel(Int(cursor.int(forColumnIndex: 0)), cursor.string(forColumn: languageField)!, Int(cursor.int(forColumnIndex: 5)), language))
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    /// Gets country information from the DB
    ///
    /// - Warning:
    /// - parameter idCountries:
    /// - parameter language:
    /// - returns:
    func getCountriesList(idCountries: [Int]!, language: String) -> [CountryModel]{
        var results = [CountryModel]()
        
        let languageField = Constants.shared.field_countries_countryName + "_" + language
        
        var query = "select distinct * from " + Constants.shared.tableName_countries
        
        if idCountries != nil && !idCountries.isEmpty {
            query = query + " where " + Constants.shared.field_countries_id + " in (" + String(idCountries[0])
            for index in 1..<idCountries.count {
                query = query + "," + String(idCountries[index])
            }
            query = query + ")"
        }
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            
            while cursor.next(){
                results.append(CountryModel(Int(cursor.int(forColumnIndex: 0)), cursor.string(forColumn: languageField)!, language))
                print("Column count: " + String(cursor.columnCount) )
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    func getEntitiesList(idEntity: Int!, idCategory: Int!, idCountry: Int!, idCity: Int!, language: String) -> [EntityModel]{
        var results = [EntityModel]()
        var previousClause = false
        
        let descriptionField = Constants.shared.field_entities_description + "_" + language
        let cityField = Constants.shared.field_cities_cityName + "_" + language
        
        var query = "select * from " + Constants.shared.tableName_entities + " inner join " + Constants.shared.tableName_cities + " on " + Constants.shared.tableName_cities + "." + Constants.shared.field_cities_id + " = " + Constants.shared.field_entities_id_city + " inner join " + Constants.shared.tableName_countries + " on " + Constants.shared.tableName_countries + "." + Constants.shared.field_countries_id + " = " + Constants.shared.tableName_entities + "." + Constants.shared.field_entities_id_country
        
        //inner join cities on cities.id = entities.id_city inner join countries on countries.id = entities.id_country
        
        if idCategory != nil && idCategory != 0 {
            query = query + " where " + Constants.shared.tableName_entities + "." + Constants.shared.field_entities_id_category + " = " + String(idCategory)
            previousClause = true
        }
        
        if idEntity != nil && idEntity != 0 {
            if previousClause {
                query = query + " and "
            } else {
                query = query + " where "
                previousClause = true
            }
            
            query = query + Constants.shared.tableName_entities + "." + Constants.shared.field_entities_id + " = " + String(idEntity)
        }
        
        if idCountry != nil && idCountry != 0 {
            if previousClause {
                query = query + " and "
            } else {
                query = query + " where "
                previousClause = true
            }
            
            query = query + Constants.shared.tableName_entities + "." + Constants.shared.field_entities_id_country + " = " + String(idCountry)
        }
        
        if idCity != nil && idCity != 0 {
            if previousClause {
                query = query + " and "
            } else {
                query = query + " where "
            }
            
            query = query + Constants.shared.tableName_entities + "." + Constants.shared.field_entities_id_city + " = " + String(idCity)
        }
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            
            while cursor.next(){
                let entity = EntityModel()
                entity.id = Int(cursor.int(forColumnIndex: 0))
                entity.entityName = cursor.string(forColumnIndex: 1)
                entity.entityDescription = cursor.string(forColumn: descriptionField)
                entity.address = cursor.string(forColumnIndex: 6)
                entity.longitude = cursor.double(forColumnIndex: 8)
                entity.latitude = cursor.double(forColumnIndex: 7)
                entity.idCity = Int(cursor.int(forColumnIndex: 9))
                entity.idCountry = Int(cursor.int(forColumnIndex: 10))
                entity.idCategory = Int(cursor.int(forColumnIndex: 11))
                entity.phoneNumber = cursor.string(forColumnIndex: 12)
                entity.phoneNumber2 = cursor.string(forColumnIndex: 13)
                entity.link = cursor.string(forColumnIndex: 14)
                entity.email = cursor.string(forColumnIndex: 15)
                entity.cityName = cursor.string(forColumn: cityField)
                
                results.append(entity)
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
}
