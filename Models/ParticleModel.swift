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
    var tagCode: Int!
    
    let separatorNewLine = "\\|"
    
    init(){
        
    }
    
    init(_ id: Int,_ text: String,_ idSubject: Int,_ subjectText: String,_ tagCode: Int,_ language: String){
        self.id = id
        self.text = text
        self.idSubject = idSubject
        self.subjectText = subjectText
        self.tagCode = tagCode
        self.language = language
        self.particleTexts = text.components(separatedBy: separatorNewLine)
        
    }
    
    func getMainTag() -> Int{
        return Int(String(String(tagCode).dropLast(4)))!
    }
    
    func getResidenceTag() -> Int{
        return Int(String(String(tagCode).dropLast(3).dropFirst(1)))!
    }
    
    func getCluster() -> Int{
        return Int(String(String(tagCode).dropLast(2).dropFirst(2)))!
    }
    
    func getOrder() -> Int{
        return Int(String(String(tagCode).dropFirst(3)))!
    }
    
}
