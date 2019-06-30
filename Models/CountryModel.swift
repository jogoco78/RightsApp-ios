//
//  CountryModel.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 27/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class CountryModel {
    var id: Int!
    var countryName: String!
    var language: String!
    
    init(){
        
    }
    
    init(_ id: Int,_ countryName: String,_ language: String){
        self.id = id
        self.countryName = countryName
        self.language = language
    }
}
