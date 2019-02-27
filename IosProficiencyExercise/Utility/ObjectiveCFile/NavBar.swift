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

class NavBar: NSObject, UITextFieldDelegate {
    
    static var dynamicView = UIView()
    static var vc = UIViewController()
    
    
    static func setupTitle(text: String,sender : AnyObject){
        vc = (sender as? UIViewController)!
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.white
        vc.navigationItem.titleView = label;
        label.text = text
        label.font = UIFont(name: "TradeGothicLTStd-BdCn20", size: 23)
        label.sizeToFit()
    }
    
    class func goToBack(sender : AnyObject){
        vc = (sender as? UIViewController)!
        let button   = UIButton(type: UIButtonType.system) as UIButton
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        let image : UIImage? = UIImage(named:"ic_back")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(NavBar.goback), for: UIControlEvents.touchUpInside)
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: button)
        vc.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    
    class func goback(){
        vc.navigationController!.popViewController(animated: true)
    }
    
    class func navTitleView(withText titleText: String) -> UILabel {
        let fontVal: UIFont? = FontFactory.knockoutHTF28JuniorFeatherwt(withSize: 24.0)
        let width: Float = Float(titleText.size(attributes: [NSFontAttributeName : fontVal!]).width)
        let title = UILabel(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(width), height: CGFloat(44)))
        title.textColor = UIColor.white
        title.text = titleText
        title.font = fontVal
        title.backgroundColor = UIColor.clear
        return title
    }
    
    class func navTitleTextView(withText titleText: String, placeholderText:String) -> UITextField {
        let fontVal: UIFont? = FontFactory.knockoutHTF28JuniorFeatherwt(withSize: 24.0)
        let width: Float = Float(titleText.size(attributes: [NSFontAttributeName : fontVal!]).width)
        let title = UITextField(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(width), height: CGFloat(44)))
        title.textColor = UIColor.white
        title.text = titleText
        title.font = fontVal
        title.textAlignment = .center
        title.backgroundColor = UIColor.clear
        title.placeholder = "TAP HERE TO ADD A TITLE"
        title.placeHolderColor = UIColor.white
        return title
    }
    
    class func buildBackBtn() -> UIButton
    {
        let button = UIButton(type: .custom)
        let backImage = UIImage(named: "ic_back")
        button.frame = CGRect(x: 0, y: 0, width: FORMULA_HEADER_HEIGHT, height: FORMULA_HEADER_HEIGHT)
        button.setImage(backImage, for: .normal)
        button.setImage(backImage, for: .highlighted)
        button.accessibilityLabel = NSLocalizedString("Home", comment: "")
        
        return button
    }
    
    class func buttonWith(text : String) -> UIButton{
        
        let button = UIButton(type: .custom)
        
        button.frame = CGRect(x: 0, y: 0, width: FORMULA_HEADER_HEIGHT, height: FORMULA_HEADER_HEIGHT)
        button.setTitle(text, for: UIControlState.normal)
        button.setTitle(text, for: UIControlState.highlighted)
        
        button.setTitleColor(UIColor(white: 0.7, alpha: 1.0), for: .normal)
        button.setTitleColor(UIColor(white: 0.7, alpha: 1.0), for: .highlighted)
        button.titleLabel?.font = FontFactory.tradeGothicBoldCondensed(withSize: 12.0)
        
        return button
    }
    
    class func buildShareBtn() -> UIButton
    {
        let button = UIButton(type: .custom)
        let backImage = UIImage(named: "Util_Share")
        button.frame = CGRect(x: 0, y: 0, width: FORMULA_HEADER_HEIGHT, height: FORMULA_HEADER_HEIGHT)
        button.setImage(backImage, for: .normal)
        button.setImage(backImage, for: .highlighted)
        button.accessibilityLabel = NSLocalizedString("Share", comment: "")
        
        return button
    }
    
    class func buildHomeBtn() -> UIButton
    {
        let homeButton = UIButton(type: .custom)
        let homeImage = UIImage(named: "home_button")
        homeButton.setImage(homeImage, for: .normal)
        homeButton.setImage(homeImage, for: .highlighted)
        homeButton.frame = CGRect(x: 0, y: 0, width: FORMULA_HEADER_HEIGHT, height: FORMULA_HEADER_HEIGHT)
        
        return homeButton
    }
    
    class func buildAccountBtn() -> UIButton
    {
        let profileImageDir = Utility.createDirectoryInDoc(path: localpath!, directoryName: PROFILE_IMAGE_DIR)
        let localImagePath = "\(profileImageDir)/\( PROFILE_IMAGE)"
        
        var profileImage = UIImage(named: "accounts")
        if(Utility.isFileExistAtPath(path: localImagePath)){
            profileImage = UIImage(named: localImagePath)
        }
        
        let accountBut = UIButton(type: .custom)
        accountBut.frame = CGRect(x: 0, y: 0, width: 23.0, height: 23.0)
        accountBut.layer.cornerRadius = 0.5 * accountBut.bounds.size.width
        accountBut.clipsToBounds = true
        accountBut.layer.borderWidth = 0.5
        accountBut.layer.borderColor = Utility.UIColorFromRGB(rgb: 0xff383838).cgColor
        accountBut.setImage(profileImage, for: .normal)
        accountBut.setImage(profileImage, for: .highlighted)
        
        return accountBut
    }
    
    
}
