//
//  HomeModel.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit

struct DataModel:Codable {
    var navbarTitle:String
    var tableRows = [TableRowsDesc]()
}

struct TableRowsDesc:Codable {
    var cellTitle:String
    var  cellDescription:String
    var  cellImageRefernce:String
}
