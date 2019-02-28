//
//  HomeViewModel.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
    //MARK: - This method take the data from Network class and callback to View.
    class func getAppList(_ url:String,completion:@escaping(_ data:DataModel?,_ errcode:Int)->Void){
            NetworkClass.fetchAppList(strUrl:url, success: { data in
            let  dataModel:DataModel = data as! DataModel
            completion(dataModel, SUCESS)
            
        },failure:{ error in
            
        } )
    }
    
}
