//
//  CategoryModel.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 26/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class CategoryModel {
    var id: Int!
    var text: String!
    var language: String!
    
    init() {
        
    }
    
    init(_ id: Int,_ text: String,_ language: String) {
        self.id = id
        self.text = text
        self.language = language
    }
}
