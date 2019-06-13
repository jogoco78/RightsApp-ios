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
    
    
    //Fields
    let field_questions_id = "id"
}
