//
//  NetworkClass.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit

class NetworkClass: NSObject {
    
    class func SiteCoreGetRequest(strUrl:String,param:String,success:@escaping(Any)->Void,failure:@escaping(Error)->Void){
    
        let url = URL(string: strUrl)
        let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
             guard let reponseData = data else{
             return
             }
             
             let decoder = JSONDecoder()
             
             do {
             decoder.keyDecodingStrategy = .convertFromSnakeCase
             let loginModelObject =  try decoder.decode( DataModel.self, from: reponseData)
             }catch{
             
             }
            
            /*
             do{
             //For
             guard let data = try JSONSerialization.jsonObject(with: reponseData, options: []) as? [String:Any]else{
             return
             }
             // Codable
             let decoder = JSONDecoder()
             decoder.keyDecodingStrategy = .convertFromSnakeCase
             decoder.decode([LoginViewModel.self()], from: reponseData)
             
             
             }catch{
             
             
             }
             */
        }
        dataTask.resume()
    }

}
