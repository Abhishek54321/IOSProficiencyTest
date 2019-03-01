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
/*
   Creating Title Label and setting font.
*/
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name:"HelveticaNeue-Bold", size: 16)

        return title
    }()
/*
     Creating Description Label and setting font.
*/
    lazy var descLabel:UILabel = {
        let descLabel = UILabel()
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.font = UIFont(name:"HelveticaNeue", size: 10.5)
        descLabel.numberOfLines = 0
        descLabel.sizeToFit()
        return descLabel
    }()
/*
 Creating Image View and setting mode
 
 */
    lazy var cellImageView:UIImageView = {
        let cellImageView = UIImageView()
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleToFill
        return cellImageView
    }()

    
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
/*
     Adding constraint in ContainerTableViewCell for iphones devices
 */
    func buildCellForIphone() {
        let tgWidth: CGFloat = UIScreen.main.bounds.size.width - 120.0

        self.addSubview(cellImageView)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)

        cellImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cellImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.cellImageView.trailingAnchor,constant:10.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant:20.0).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: -2.0).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: self.cellImageView.trailingAnchor,constant:10.0).isActive = true
        descLabel.widthAnchor.constraint(equalToConstant: tgWidth).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    

      

    }
    
//MARK: - buildCellForIpad
    /*
     Adding constraint in ContainerTableViewCell for iPad devices
     */
    func buildCellForIpad() {
        let tgWidth: CGFloat = UIScreen.main.bounds.size.width - 290.0
      
        self.addSubview(cellImageView)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
        
        cellImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        cellImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.cellImageView.trailingAnchor,constant:60.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant:20.0).isActive = true
        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 22)
        
        descLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: -2.0).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: self.cellImageView.trailingAnchor,constant:60.0).isActive = true
        descLabel.widthAnchor.constraint(equalToConstant: tgWidth).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
         descLabel.font = UIFont(name:"HelveticaNeue", size: 17)
        
    }
   
}
