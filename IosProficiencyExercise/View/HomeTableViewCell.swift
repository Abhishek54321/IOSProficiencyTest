//
//  HomeTableViewCell.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    var cellTitle:String = ""
    var cellDesc:String  = ""
    var cellImage:UIImage? = nil
    var title: MultilineLabel?
    var desc: MultilineLabel?
    var titleLabel:UILabel?
    var descLabel:UILabel?
    var link: String = ""
    var titleSt: String = ""
    var descSt: String = ""
    var cellImageView:UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // buildLabels()
        // buildCell()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if UIDevice.current.userInterfaceIdiom == .pad{
           buildCellForIpad()
        }else{
          buildCellForIphone()
        }
       
    }
    func buildCellForIphone() {
        //UIScreen.main.bounds.size.width
        let tgWidth: CGFloat = UIScreen.main.bounds.size.width - 20.0
        cellImageView = UIImageView()
        cellImageView?.frame = CGRect(x: 10, y: 10, width: 120, height: 90)
        PViewUtils.move(cellImageView, toTopLeft: CGPoint(x: CGFloat(20.0), y: CGFloat(20.0)))
        titleLabel = UILabel()
        titleLabel?.frame = CGRect(x: 0, y: 0, width:tgWidth, height: 40)
        titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 14)
        PViewUtils.move(titleLabel, toTopLeft: CGPoint(x:CGFloat(10.0 + (cellImageView?.frame.size.width)! + 15.0), y: CGFloat(20.0)))
        
        descLabel = UILabel()
        descLabel?.frame = CGRect(x: 0, y: 100, width:tgWidth, height: 40)
        descLabel?.font = UIFont(name:"HelveticaNeue", size: 12)
        descLabel?.numberOfLines = 0
        PViewUtils.move(descLabel, toTopLeft: CGPoint(x: CGFloat(10.0 + (cellImageView?.frame.size.width)! + 15.0), y: CGFloat(20.0 + (titleLabel?.frame.size.height)! + 6.0)))
        
        addSubview(cellImageView!)
        addSubview(titleLabel!)
        addSubview(descLabel!)
    }
    
    func buildCellForIpad() {
        let tgWidth: CGFloat = UIScreen.main.bounds.size.width - 20.0
        cellImageView = UIImageView()
        cellImageView?.frame = CGRect(x: 10, y: 10, width: 200, height: 90)
        cellImageView?.contentMode = .scaleToFill
        PViewUtils.move(cellImageView, toTopLeft: CGPoint(x: CGFloat(20.0), y: CGFloat(20.0)))
        
        titleLabel = UILabel()
        titleLabel?.frame = CGRect(x: 0, y: 0, width:tgWidth, height: 40)
        titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        PViewUtils.move(titleLabel, toTopLeft: CGPoint(x:CGFloat(10.0 + (cellImageView?.frame.size.width)! + 50.0), y: CGFloat(20.0)))
        
        descLabel = UILabel()
        descLabel?.frame = CGRect(x: 0, y: 100, width:tgWidth, height: 40)
        descLabel?.numberOfLines = 0
        descLabel?.font = UIFont(name:"HelveticaNeue", size: 16)
        PViewUtils.move(descLabel, toTopLeft: CGPoint(x: CGFloat(10.0 + (cellImageView?.frame.size.width)! + 50.0), y: CGFloat(20.0 + (titleLabel?.frame.size.height)! + 20.0)))
        
        addSubview(cellImageView!)
        addSubview(titleLabel!)
        addSubview(descLabel!)
    }
    
    func buildLabels() {
        let tgWidth: CGFloat = frame.size.width - 82.0
        title = MultilineLabel(font: FontFactory.knockoutHTF28JuniorFeatherwt(withSize: 22.0), width: Float(tgWidth), lineHeight: 20.0, text: titleSt)
        title?.isUserInteractionEnabled = false
        title?.textColor = UIColor.black
        desc = MultilineLabel(font: FontFactory.gothamLight(withSize: 13.0), width: Float(tgWidth), lineHeight: 12.0, text: descSt)
        desc?.isUserInteractionEnabled = false
        desc?.textColor = UIColor.black//(hexString: "6b6b6b")
        PViewUtils.move(title, toTopLeft: CGPoint(x: CGFloat(20.0), y: CGFloat(20.0)))
        PViewUtils.move(desc, toTopLeft: CGPoint(x: CGFloat(20.0), y: CGFloat(20.0 + (title?.frame.size.height)! + 6.0)))
        addSubview(title!)
        addSubview(desc!)
        //let icon = UIImageView(image: UIImage(named: "resources_icon"))
        // icon.isUserInteractionEnabled = false
        //            PViewUtils.anchorView(icon, top: kMarginFlexible, right: 13.0, bottom: 25.0, left: kMarginFlexible, in: self)
        //            addSubview(icon)
        //            let line = UIView(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0), width: CGFloat(frame.size.width), height: CGFloat(1.0)))
        //            line.backgroundColor = UIColor(hexString: "dedede")
        // addSubview(line)
        
        let titleWidth: CGFloat = frame.size.width - 82.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        title?.removeFromSuperview()
        desc?.removeFromSuperview()
        //buildLabels()
        
    }
    func setItem(titleTxt: String, descTxt:String) {
        titleSt = titleTxt
        descSt = descTxt
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
