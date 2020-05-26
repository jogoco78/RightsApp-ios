//
//  Constants.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 13/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

struct Constants {
    struct database {
        static let name = "rightsapp_v7_utf16.db"
        struct questions{
            static let name = "questions"
            static let id = "id"
            static let text = "text"
        }
        struct questions_answers{
            static let name = "questions_answers"
            static let id_question = "id_question"
            static let id_answer = "id_answer"
            static let id_next_question = "id_next_question"
            static let id_tag_raised = "id_tag_raised"
        }
        struct answers{
            static let name = "answers"
            static let id = "id"
        }
        struct particles{
            static let name = "particles"
            static let id = "id"
            static let text = "text"
            static let id_subject = "id_subject"
        }
        struct particles_tags{
            static let name = "particles_tags"
            static let id_particle = "id_particle"
            static let tag_code = "tag_code"
        }
        struct subjects{
            static let name = "subjects"
            static let id = "id"
            static let text = "text"
        }
        struct categories{
            static let name = "categories"
            static let id = "id"
            static let text = "category"
        }
        struct cities{
            static let name = "cities"
            static let id = "id"
            static let city_name = "city"
            static let id_country = "id_country"
        }
        struct countries{
            static let name = "countries"
            static let id = "id"
            static let country_name = "country"
        }
        struct entities{
            static let name = "entities"
            static let id = "id"
            static let description = "description"
            static let id_city = "id_city"
            static let id_country = "id_country"
            static let id_category = "id_category"
        }
    }
    struct categories{
        static let police_stations = 1
        static let victim_assistance_offices = 2
        static let medical_centres = 3
        static let consulates_embassies = 4
    }
    struct GPS{
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    struct tags{
        static let common_crime = 1
        static let terrorism = 2
        static let violence_against_women = 3
        static let domestic_violence = 4
        static let violent_crimes = 5
        static let sexual_attack = 6
        static let EU_resident = 7
        static let non_EU_resident = 8
        static let spanish_resident = 9
    }
    struct keys{
        static let particle_id = "particleID"
        static let tags = "tags"
        static let parameters = "parameters"
        static let searchIDEntity = "entityTypeID"
        static let searchIDCountry = "countryID"
        static  let searchIDCity = "cityID"
        static let entitySelected = "entitySelected"
        static let user_selected_tag =  "user_selected_tag"
        static let main_tag = "main_tag"
        static let side_tag = "side_tag"
        static let residence_tag = "residence_tag"
        static let phone_to_call = "phone_to_call"
    }
    struct call{
        static let emergency = "112"
        static let violence_against_women = "016"
    }
    struct text{
        static let newLine = "\n"
        static let newSeparator = "\n\n-"
        static let rawSeparator = "--"
    }
}
/*class Constants: NSObject {
    static let shared: Constants = Constants()
    
    //MARK: Database name
    let databaseName = "rightsapp_v6_utf16.db"
    
    let newLine = "\n"
    let newSeparator = "\n\n-"
    let rawSeparator = "--"
    
    //MARK: Emergency phone number
    let emergencyCall = "112"
    
    //MARK: Stored information keys
    //let particles_id_subject = "idSubject"
    let particle_id = "particleID"
    let tags = "tags"
    let parameters = "parameters"
    let searchIDEntity = "entityTypeID"
    let searchIDCountry = "countryID"
    let searchIDCity = "cityID"
    let entitySelected = "entitySelected"
    let user_selected_tag =  "user_selected_tag"
    let main_tag = "main_tag"
    let side_tag = "side_tag"
    let residence_tag = "residence_tag"
    
     //MARK: - Table names
    let tableName_questions = "questions"
    let tableName_questions_answers = "questions_answers"
    let tableName_answers = "answers"
    let tableName_particles = "particles"
    let tableName_particles_tags = "particles_tags"
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
    let field_particles_tags_idParticle = "id_particle"
    let field_particles_tags_tagCode = "tag_code"
    //let field_particles_mainTags_idTag = "id_tag"
    //let field_particles_mainTags_idParticle = "id_particle"
    //let field_particles_residenceTags_idTag = "id_tag"
    //let field_particles_residenceTags_idParticle = "id_particle"
    let field_subjects_id = "id"
    let field_subjects_text = "text"
    let field_subjects_priority = "priority"
    let field_subjects_cluster = "cluster"
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
    
    
}*/
