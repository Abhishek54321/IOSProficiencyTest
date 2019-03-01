//
//  HomeViewModel.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//This file is used for getting data from Network class,
//Parsing Data and storing in respective Model class.

import UIKit

class ContainerViewModel {
/*
 This method is used for getting data from Network Class
     and parsing data and Storing into DataModel class.

*/
   class func getAppList(_ url:String,completion:@escaping(_ data:DataModel?,_ errcode:Int)->Void){
            NetworkClass.fetchAppList(strUrl:url, success: { data in
                do {
                    let decoder = JSONDecoder()
                    let dataModel = try decoder.decode(DataModel.self, from: data as! Data)
                    
                    completion(dataModel,SUCESS)
                    
                } catch {
                    NSLog("ERROR \(error.localizedDescription)")
                }
            
        },failure:{ error in
            
        } )
    }
    
}
