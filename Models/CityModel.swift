//
//  CitiesModel.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 12/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class CityModel {
    var id: Int!
    var cityName: String!
    var idCountry: Int!
    var language: String!
    
    // MARL: - Initializers
    init(){
        
    }
    
    init(_ id: Int,_ cityName: String,_ idCountry: Int,_ language: String){
        self.id = id
        self.cityName = cityName
        self.idCountry = idCountry
        self.language = language
    }
    
}
