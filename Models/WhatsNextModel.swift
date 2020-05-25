//
//  WhatsNextModel.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 25/05/2020.
//  Copyright © 2020 uab. All rights reserved.
//

import UIKit

class WhatsNextModel{
    var id: Int!
    var data: String!
    var language: String!
   
   init() {
       
   }
   
   init(_ id:Int,_ data:String,_ language:String){
       self.id = id
       self.data = data
       self.language = language
   }
}

