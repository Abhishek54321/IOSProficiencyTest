/** -------------------------------------------------------------
 * Copyright (C) 2017 Redken, Inc. All trade marks registered
 *
 * This file is part of Redken Style Station Mobile Project.
 *
 * Redken Style Station Mobile Project can not be copied and/or
 *
 * distributed without the express permission of Redken, Inc.
 *
 * -------------------------------------------------------------
 **/

import UIKit

class ActivityIndicator
{
    class func showActiviyIndicator()
    {
        
        self.showActivity()
    }
    
    class func showActivity()
    {
        var config : ActivityView.Config = ActivityView.Config()
        config.size = 120
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.white
        config.spinnerLineWidth = 3.0
        config.foregroundColor = UIColor.black
        config.foregroundAlpha = 0.5
        
        ActivityView.setConfig(config)
        ActivityView.show(true)
    }
    
    class func showActivityonTop()
    {
        var config : ActivityView.Config = ActivityView.Config()
        config.size = 120
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.white
        config.spinnerLineWidth = 3.0
        config.foregroundColor = UIColor.black
        config.foregroundAlpha = 0.5
        
        ActivityView.setConfig(config)
        ActivityView.show(true, isDisplayIndicatorOnTop : true)
    }
    
    
    class func hideActivityIndicator()
    {
        ActivityView.hide(with : true)
    }
    
    class func showActivityIndicator(_ sender: UIViewController)
    {
        self.showActivity()
    }
    
    class func hideActivity(with Animation : Bool = true){
        //Activity is going done
        ActivityView.hide(with : Animation)
    }
    
}




