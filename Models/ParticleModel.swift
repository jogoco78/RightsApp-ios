//
//  ParticleModel.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 19/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class ParticleModel {
    var id: Int!
    var text: String!
    var idSubject: Int!
    var language: String!
    
    init(){
        
    }
    
    init(_ id: Int,_ text: String,_ idSubject: Int,_ language: String){
        self.id = id
        self.text = text
        self.idSubject = idSubject
        self.language = language
    }
}
