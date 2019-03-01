//
//  NetworkClass.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//This file is used for taking data from  server and passes to ViewModel class.
//Here Passing data to ContainerViewModel.

import UIKit

class NetworkClass: NSObject {
    
    /*
     This method is used for fetching list
     of Data from server.Here Returning Data to ContainerViewModel.
     */
    class func fetchAppList(strUrl:String,success:@escaping(Any)->Void,failure:@escaping(Error)->Void) {
        URLSession.shared.dataTask(with: URL(string: strUrl)!) { (data, res, err) in
            if let facts = data {
                if let value = String(data: facts, encoding: String.Encoding.ascii) {
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        success(jsonData)
                    }
                }
                
            }
            }.resume()
        
    }
}




