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
    let databaseFileName = Constants.database.name
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
        let languageField = Constants.database.questions.text + "_" + language
        
        var query = "SELECT * FROM " + Constants.database.questions.name + " WHERE "
        query = query + Constants.database.questions.id + " IN (" + String(id_questions[0])
        
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
        
        let select = "select " + Constants.database.answers.id + ", text_" + language + " from " + Constants.database.answers.name
        let inner_join = " inner join " + Constants.database.questions_answers.name + " on " + Constants.database.questions_answers.id_answer + " = " + Constants.database.answers.id
        let whereq = " where " + Constants.database.questions_answers.id_question + " = " + String(idQuestion)
        
        let query = select + inner_join + whereq
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
        
        let select = "select " + Constants.database.questions_answers.id_next_question + " from " + Constants.database.questions_answers.name
        let whereq = " where " + Constants.database.questions_answers.id_question + " = " + String(idQuestion) + " and " + Constants.database.questions_answers.id_answer + " = " + String(idAnswer)
        let query = select + whereq
        
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
        
        let select = "select " + Constants.database.questions_answers.id_tag_raised + " from " + Constants.database.questions_answers.name
        let whereq = " where " + Constants.database.questions_answers.id_question + " = " + String(idQuestion) + " and " + Constants.database.questions_answers.id_answer + " = " + String(idAnswer)
        
        let query =  select + whereq
        
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
    
    /*func getSubjectsIDByTag(idTags: [Int], language: String) -> [Int] {
        let particles = getParticlesByTag(idTags: idTags, language: language)
        var idSubjects = [Int]()
        
        for particle in particles {
            idSubjects.append(particle.idSubject)
        }
        
        return idSubjects
    }*/
    
    /*func getSubjectsTextByTag(idTags: [Int], language: String) -> [String] {
        let particles = getParticlesByTag(idTags: idTags, language: language)
        var idSubjects = [Int]()
        
        for particle in particles {
            idSubjects.append(particle.idSubject)
        }
        
        return getSubjectbyID(idSubjects: idSubjects, language: language)
    }*/
    
    func getSubjectbyID(idSubjects: [Int], language: String) -> [String] {
        var results = [String]()
        
        var query = "select * from " + Constants.database.subjects.name + " where " + Constants.database.subjects.id + " in (" + String(idSubjects[0])
        for index in 1..<idSubjects.count {
            query.append("," + String(idSubjects[index]))
        }
        query.append(")")
        
        do {
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
                //results.append(cursor.string(forColumn: Constants.shared.field_subjects_text + language)!)
                results.append(cursor.string(forColumn: Constants.database.subjects.text + "_" + language)!)
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return results
    }
    
    func getParticlesByTag(_ main_tag: Int,_ residence_tag: Int,_ language: String) -> [ParticleModel] {
        var id_particles = [Int]()
        var tag_codes = [Int]()
        
        let select = "select distinct pt." + Constants.database.particles_tags.id_particle
        + ",pt." + Constants.database.particles_tags.tag_code + " from " + Constants.database.particles_tags.name + " pt"
        
        var whereq = " where pt." + Constants.database.particles_tags.tag_code + " like \'"
        if (residence_tag == 0){
            whereq = whereq + String(main_tag) + "%\'"
        }else {
            whereq = whereq + String(main_tag) + String(residence_tag) + "%\'"
        }
        
        //Construct the query and launches
        let query = select + whereq
        do {
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
                id_particles.append(Int(cursor.int(forColumnIndex: 0)))
                tag_codes.append(Int(cursor.int(forColumnIndex: 1)))
            }
            
            cursor.close()
        }catch {
            print("Could not execute the query")
        }
        
        return getParticles(id_particles, tag_codes, language)
    }
    
    func getParticles(_ idParticles: [Int]!,_ tag_codes: [Int],_ language: String) -> [ParticleModel] {
        var results = [ParticleModel]()
        
        let select = "select distinct p." + Constants.database.particles.id + ",p." + Constants.database.particles.text + "_" + language + ",s." + Constants.database.subjects.id + ",s." + Constants.database.subjects.text + "_" + language
            + " from " + Constants.database.particles.name + " p," + Constants.database.subjects.name + " s, " + Constants.database.particles_tags.name + " pt"
        
        //Construct where clause
        var qwhere = ""
        if(idParticles != nil){
            qwhere = " where p." + Constants.database.particles.id + " in ("
            var first = true
            for id in idParticles{
                if first{
                    first = false
                }else{
                    qwhere.append(",")
                }
                qwhere.append(String(id))
            }
            //There is a previous where clause
            qwhere.append(") and ")
        }else{
            //There is no previous where clause
            qwhere.append("where ")
        }
        qwhere.append("s." + Constants.database.subjects.id + " = p." + Constants.database.particles.id_subject)
        
        let query = select + qwhere
        var index = 0
        do {
            let cursor = try database.executeQuery(query, values: nil)
            while cursor.next(){
                //Particle ID; Particle Text; Subject ID; Subject Text; Tag code; Language
                results.append(ParticleModel(Int(cursor.int(forColumnIndex: 0)), cursor.string(forColumnIndex: 1)!, Int(cursor.int(forColumnIndex: 2)), cursor.string(forColumnIndex: 3)!, tag_codes[index], language))
                index+=1
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
        
        let languageField = Constants.database.categories.text + "_" + language
        
        let query = "select * from " + Constants.database.categories.name
        
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
        
        let languageField = Constants.database.cities.city_name + "_" + language
        
        var query = "select * from " + Constants.database.cities.name
        
        if idCities != nil && !idCities.isEmpty {
            query = query + " where " + Constants.database.cities.id + " in (" + String(idCities[0])
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
        
        let languageField = Constants.database.cities.city_name + "_" + language
        
        let query = "select * from " + Constants.database.cities.name + " where " + Constants.database.cities.id_country + " = " + String(idCountry) + " order by " + languageField
        
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
        
        let languageField = Constants.database.cities.city_name + "_" + language
        
        let select = "select distinct c.* from " + Constants.database.entities.name + " e," + Constants.database.cities.name + " c "
        let qwhere = "where e." + Constants.database.entities.id_category + " = " + String(idCategory)
        let and = " and e." + Constants.database.entities.id_city + " = c." + Constants.database.cities.id
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
        
        let languageField = Constants.database.countries.country_name + "_" + language
        
        var query = "select distinct * from " + Constants.database.countries.name
        
        if idCountries != nil && !idCountries.isEmpty {
            query = query + " where " + Constants.database.countries.id + " in (" + String(idCountries[0])
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
        
        let descriptionField = Constants.database.entities.description + "_" + language
        let cityField = Constants.database.cities.city_name + "_" + language
        
        var query = "select * from " + Constants.database.entities.name + " inner join " + Constants.database.cities.name + " on " + Constants.database.cities.name + "." + Constants.database.cities.id + " = " + Constants.database.entities.id_city + " inner join " + Constants.database.countries.name + " on " + Constants.database.countries.name + "." + Constants.database.countries.id + " = " + Constants.database.entities.name + "." + Constants.database.entities.id_country
        
        //inner join cities on cities.id = entities.id_city inner join countries on countries.id = entities.id_country
        
        if idCategory != nil && idCategory != 0 {
            query = query + " where " + Constants.database.entities.name + "." + Constants.database.entities.id_category + " = " + String(idCategory)
            previousClause = true
        }
        
        if idEntity != nil && idEntity != 0 {
            if previousClause {
                query = query + " and "
            } else {
                query = query + " where "
                previousClause = true
            }
            
            query = query + Constants.database.entities.name + "." + Constants.database.entities.id + " = " + String(idEntity)
        }
        
        if idCountry != nil && idCountry != 0 {
            if previousClause {
                query = query + " and "
            } else {
                query = query + " where "
                previousClause = true
            }
            
            query = query + Constants.database.entities.name + "." + Constants.database.entities.id_country + " = " + String(idCountry)
        }
        
        if idCity != nil && idCity != 0 {
            if previousClause {
                query = query + " and "
            } else {
                query = query + " where "
            }
            
            query = query + Constants.database.entities.name + "." + Constants.database.entities.id_city + " = " + String(idCity)
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
