//
//  Constants.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 13/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static let shared: Constants = Constants()
    let databaseName = "rightsapp_v5_utf16.db"
    
    //Emergency phone number
    let emergencyCall = "935812235"
    
    //Stored information keys
    let particles_id_subject = "idSubject"
    let tags = "tags"
    let parameters = "parameters"
    let searchIDEntity = "entityTypeID"
    let searchIDCountry = "countryID"
    let searchIDCity = "cityID"
    
    //Table names
    let tableName_questions = "questions"
    let tableName_questions_answers = "questions_answers"
    let tableName_answers = "answers"
    let tableName_particles = "particles"
    let tableName_particles_tags = "particles_tags"
    let tableName_subjects = "subjects"
    let tableName_categories = "categories"
    let tableName_cities = "cities"
    let tableName_countries = "countries"
    let tableName_entities = "entities"
    
    
    //Fields
    let field_questions_id = "id"
    let field_answers_id = "id"
    let field_questions_answers_id_question = "id_question"
    let field_questions_answers_id_answer = "id_answer"
    let field_questions_answers_id_next_question = "id_next_question"
    let field_questions_answers_id_tag_raised = "id_tag_raised"
    let field_particles_id = "id"
    let field_particles_text = "text"
    let field_particles_idSubject = "id_subject"
    let field_particles_tags_idTag = "id_tag"
    let field_particles_tags_idParticle = "id_particle"
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
    let field_entities_id_city = "id_city"
    let field_entities_id_country = "id_country"
    
    let latitude = "latitude"
    let longitude = "longitude"
}
