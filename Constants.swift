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
    
    //Table names
    let tableName_questions = "questions"
    let tableName_questions_answers = "questions_answers"
    let tableName_answers = "answers"
    
    
    //Fields
    let field_questions_id = "id"
    let field_answers_id = "id"
    let field_questions_answers_id_question = "id_question"
    let field_questions_answers_id_answer = "id_answer"
    let field_questions_answers_id_next_question = "id_next_question"
}
