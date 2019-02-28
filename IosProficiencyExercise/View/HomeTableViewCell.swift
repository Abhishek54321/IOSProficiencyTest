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
//    var title: MultilineLabel?
//    var desc: MultilineLabel?
    var titleLabel:UILabel?
    var descLabel:UILabel?
    var link: String = ""
    var titleSt: String = ""
    var descSt: String = ""
    var cellImageView:UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if UIDevice.current.userInterfaceIdiom == .pad{
           buildCellForIpad()
        }else{
          buildCellForIphone()
        }
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
//MARK: - buildCellForIphone
//Here making cell for iphones
    func buildCellForIphone() {
        //UIScreen.main.bounds.size.width
        let tgWidth: CGFloat = UIScreen.main.bounds.size.width - 120.0
        cellImageView = UIImageView()
        cellImageView?.frame = CGRect(x: 5, y: 10, width: 90, height: 90)
        PViewUtils.move(cellImageView, toTopLeft: CGPoint(x: CGFloat(10.0), y: CGFloat(10.0)))
        titleLabel = UILabel()
        titleLabel?.frame = CGRect(x: 0, y: 0, width:tgWidth, height: 30)
        titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 14)
        PViewUtils.move(titleLabel, toTopLeft: CGPoint(x:CGFloat(10.0 + (cellImageView?.frame.size.width)! + 15.0), y: CGFloat(10.0)))
        descLabel = UILabel()
        descLabel?.frame = CGRect(x: 0, y: 100, width:tgWidth, height: 90)
        descLabel?.font = UIFont(name:"HelveticaNeue", size: 10)
        descLabel?.numberOfLines = 0
        PViewUtils.move(descLabel, toTopLeft: CGPoint(x: CGFloat(10.0 + (cellImageView?.frame.size.width)! + 15.0), y: CGFloat(2.0 + (titleLabel?.frame.size.height)!)))
        addSubview(cellImageView!)
        addSubview(titleLabel!)
        addSubview(descLabel!)
    }
    
//MARK: - buildCellForIpad
//Here making cell for iPad
    func buildCellForIpad() {
        let tgWidth: CGFloat = UIScreen.main.bounds.size.width - 290.0
        cellImageView = UIImageView()
        cellImageView?.frame = CGRect(x: 10, y: 10, width: 200, height: 130)
        cellImageView?.contentMode = .scaleToFill
        PViewUtils.move(cellImageView, toTopLeft: CGPoint(x: CGFloat(20.0), y: CGFloat(10.0)))
        titleLabel = UILabel()
        titleLabel?.frame = CGRect(x: 0, y: 0, width:tgWidth, height: 35)
        titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 22)
        PViewUtils.move(titleLabel, toTopLeft: CGPoint(x:CGFloat(10.0 + (cellImageView?.frame.size.width)! + 50.0), y: CGFloat(10.0)))
        descLabel = UILabel()
        descLabel?.frame = CGRect(x: 0, y: 100, width:tgWidth, height: 80)
        descLabel?.numberOfLines = 0
        descLabel?.font = UIFont(name:"HelveticaNeue", size: 17)
        PViewUtils.move(descLabel, toTopLeft: CGPoint(x: CGFloat(10.0 + (cellImageView?.frame.size.width)! + 50.0), y: CGFloat(5.0 + (titleLabel?.frame.size.height)! )))
        
        addSubview(cellImageView!)
        addSubview(titleLabel!)
        addSubview(descLabel!)
    }
   
    func setItem(titleTxt: String, descTxt:String) {
        titleSt = titleTxt
        descSt = descTxt
    }
   
    
}
