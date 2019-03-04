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

import Foundation
import UIKit
import SDWebImage


public class LazyImageLoad: NSObject
{
 
    public class func setImageOnImageViewFromURL(imageView : UIImageView, url:String?, response:@escaping (_ image : UIImage?) -> Void)
    {
        if url == nil
        {
            return //URL is null, don't proceed
        }
        else
        {
            let completeURL = url
           
            let pathURL  = getURLFromString(url: completeURL!)
            if(pathURL == nil)
            {
                return
            }
            
            
            imageView.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)
            imageView.sd_setShowActivityIndicatorView(true)
            imageView.sd_setImage(with: pathURL!, completed: { (image, error, type, url) in
                response(image)
            })
        }
    }

    class func getURLFromString(url : String) -> URL?
    {
        let removePercentEncodeURL  = url.removingPercentEncoding
        let urlWithEscapeString = removePercentEncodeURL?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        if(urlWithEscapeString == nil)
        {
            return nil
        }
        
        let  strURL : URL? = URL(string: (urlWithEscapeString)!)
        return strURL
    }
    
    
    
}
