//
//  ClusterModel.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 22/04/2020.
//  Copyright © 2020 uab. All rights reserved.
//

import UIKit

class ClusterModel {
    var tag_id: Int!
    var description: String!
    var language: String!
    
    init() {
        
    }
    
    init(_ tag_id:Int,_ description:String,_ language:String){
        self.tag_id = tag_id
        self.description = description
        self.language = language
    }
}
