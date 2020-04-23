//
//  ParticleModel.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 19/06/2019.
//  Copyright © 2019 Jorge Gonzalez Conejero. All rights reserved.
//

import UIKit

class ParticleModel {
    var id: Int!
    var text: String!
    var idSubject: Int!
    var subjectText: String!
    var particleTexts: [String]!
    var language: String!
    
    let separatorNewLine = "--"
    
    init(){
        
    }
    
    init(_ id: Int,_ text: String,_ idSubject: Int,_ subjectText: String,_ language: String){
        self.id = id
        self.text = text
        self.idSubject = idSubject
        self.subjectText = subjectText
        self.language = language
        self.particleTexts = text.components(separatedBy: separatorNewLine)
        
    }
}
