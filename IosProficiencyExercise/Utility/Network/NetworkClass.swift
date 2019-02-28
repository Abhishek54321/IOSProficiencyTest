//
//  NetworkClass.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit


let AUTHORIZATION_EXPIRY_CODE = 401
let NETWORK_AVIALABLE_CODE = 100
class NetworkClass: NSObject {
    
    class func fetchAppList(strUrl:String,success:@escaping(Any)->Void,failure:@escaping(Error)->Void) {
        URLSession.shared.dataTask(with: URL(string: strUrl)!) { (data, res, err) in
            
            if let facts = data {
                if let value = String(data: facts, encoding: String.Encoding.ascii) {
                    
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        do {
                            let decoder = JSONDecoder()
                            let dataModel = try decoder.decode(DataModel.self, from: jsonData)
                            
                            success(dataModel)
                           
                        } catch {
                            NSLog("ERROR \(error.localizedDescription)")
                        }
                    }
                }
                
            }
            }.resume()
        
    }
}




