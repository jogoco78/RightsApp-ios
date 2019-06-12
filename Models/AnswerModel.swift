//
//  AnswerModel.swift
//  RightsApp_ios
//
//  Created by Jorge Gonzalez Conejero on 12/06/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import UIKit

class AnswerModel {
    var id: Int
    var text_es: String
    var text_en: String
    var text_pt: String
    var text_it: String
    var language: String
    
    init(_ id: Int,_ text_es: String,_ text_en: String,_ text_pt: String,_ text_it: String,_ language: String){
        self.id = id
        self.text_es = text_es
        self.text_en = text_en
        self.text_pt = text_pt
        self.text_it = text_it
        self.language = language
    }
    
}
