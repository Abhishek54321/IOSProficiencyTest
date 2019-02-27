//
//  HomeModel.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit

struct DataModel:Codable {
    var title:String?
    var rows:[TableRowsDesc]?
    
    enum CodingKeys :String,CodingKey{
        case title = "title"
        case rows = "rows"
    }
}

struct TableRowsDesc : Codable {
    var title:String?
    var  description:String?
    var  imageHref:String?
    
    enum CodingKeys : String,CodingKey{
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }
}
