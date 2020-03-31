//
//  Constants.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 13/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static let shared: Constants = Constants()
    let databaseName = "rightsapp_v6_utf16.db"
    
    let newLine = "\n"
    
    //MARK: Emergency phone number
    let emergencyCall = "112"
    
    //MARK: Stored information keys
    let particles_id_subject = "idSubject"
    let tags = "tags"
    let parameters = "parameters"
    let searchIDEntity = "entityTypeID"
    let searchIDCountry = "countryID"
    let searchIDCity = "cityID"
    let entitySelected = "entitySelected"
    
     //MARK: - Table names
    let tableName_questions = "questions"
    let tableName_questions_answers = "questions_answers"
    let tableName_answers = "answers"
    let tableName_particles = "particles"
    let tableName_particlesMain_tags = "particles_MainTags"
    let tableName_particlesResidence_tags = "particles_ResidenceTags"
    let tableName_subjects = "subjects"
    let tableName_categories = "categories"
    let tableName_cities = "cities"
    let tableName_countries = "countries"
    let tableName_entities = "entities"
    
     //MARK: - Fields
    let field_questions_id = "id"
    let field_questions_text = "text"
    let field_answers_id = "id"
    let field_questions_answers_id_question = "id_question"
    let field_questions_answers_id_answer = "id_answer"
    let field_questions_answers_id_next_question = "id_next_question"
    let field_questions_answers_id_tag_raised = "id_tag_raised"
    let field_particles_id = "id"
    let field_particles_text = "text"
    let field_particles_idSubject = "id_subject"
    let field_particles_mainTags_idTag = "id_tag"
    let field_particles_mainTags_idParticle = "id_particle"
    let field_particles_residenceTags_idTag = "id_tag"
    let field_particles_residenceTags_idParticle = "id_particle"
    let field_subjects_id = "id"
    let field_subjects_text = "text"
    let field_categories_id = "id"
    let field_categories_text = "category"
    let field_cities_id = "id"
    let field_cities_cityName = "city"
    let field_cities_idCountry = "id_country"
    let field_countries_id = "id"
    let field_countries_countryName = "country"
    let field_entities_description = "description"
    let field_entities_id = "id"
    let field_entities_id_city = "id_city"
    let field_entities_id_country = "id_country"
    let field_entities_id_category = "id_category"
    
    let latitude = "latitude"
    let longitude = "longitude"
    
     //MARK: - Tags
    let tag_common_crime = 1
    let tag_terrorism = 2
    let tag_violence_against_women = 3
    let tag_domestic_violence = 4
    let tag_violent_crimes = 5
    let tag_sexual_attack = 6
    let tag_EU_resident = 7
    let tag_non_EU_resident = 8
    let tag_spanish_resident = 9
}
