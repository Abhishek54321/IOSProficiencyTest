//
//  HomeTableViewCell.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit

class ContainerTableViewCell: UITableViewCell {
    var cellTitle:String = ""
    var cellDesc:String  = ""
    var cellImage:UIImage? = nil
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name:"HelveticaNeue-Bold", size: 16)

        return title
    }()
    lazy var descLabel:UILabel = {
        let descLabel = UILabel()
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.font = UIFont(name:"HelveticaNeue", size: 12)
        descLabel.numberOfLines = 0
        descLabel.sizeToFit()
        return descLabel
    }()
    lazy var cellImageView:UIImageView = {
        let cellImageView = UIImageView()
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleToFill
        return cellImageView
    }()
    var link: String = ""
    var titleSt: String = ""
    var descSt: String = ""

    
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
        let tgWidth: CGFloat = UIScreen.main.bounds.size.width - 120.0

        self.addSubview(cellImageView)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)

        cellImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        cellImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.cellImageView.trailingAnchor,constant:20.0).isActive = true
       // titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant:20.0).isActive = true


        descLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10.0).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: self.cellImageView.trailingAnchor,constant:20.0).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10.0).isActive = true
       descLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor,constant:-120.0).isActive = true
     //   descLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10.0).isActive = true
        //descLabel.widthAnchor.constraint(equalToConstant: tgWidth)
      //  descLabel.heightAnchor.constraint(equalToConstant: 90)

        //        descLabel.leftAnchor.constraint(equalTo: descLabel.rightAnchor, constant: cellImageView.frame.size.width + 25.0).isActive = true

    }
    
//MARK: - buildCellForIpad
//Here making cell for iPad
    func buildCellForIpad() {
        let tgWidth: CGFloat = UIScreen.main.bounds.size.width - 290.0
        cellImageView = UIImageView()
        cellImageView.frame = CGRect(x: 10, y: 10, width: 200, height: 130)
        cellImageView.contentMode = .scaleToFill
        PViewUtils.move(cellImageView, toTopLeft: CGPoint(x: CGFloat(20.0), y: CGFloat(10.0)))
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width:tgWidth, height: 35)
        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 22)
        PViewUtils.move(titleLabel, toTopLeft: CGPoint(x:CGFloat(10.0 + (cellImageView.frame.size.width) + 50.0), y: CGFloat(10.0)))
        descLabel = UILabel()
        descLabel.frame = CGRect(x: 0, y: 100, width:tgWidth, height: 80)
        descLabel.numberOfLines = 0
        descLabel.font = UIFont(name:"HelveticaNeue", size: 17)
        PViewUtils.move(descLabel, toTopLeft: CGPoint(x: CGFloat(10.0 + (cellImageView.frame.size.width) + 50.0), y: CGFloat(5.0 + titleLabel.frame.size.height )))
        
        addSubview(cellImageView)
        addSubview(titleLabel)
        addSubview(descLabel)
    }
   
    func setItem(titleTxt: String, descTxt:String) {
        titleSt = titleTxt
        descSt = descTxt
    }
   
    
}
