//
//  HomeTableView.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//This file is used for Constructing TableView and
//extending class for using TableView datasource method

import UIKit

protocol RefreshDataProtocol : class {
    func updateDataFromServer() -> Void
}

class ContainerTableView: UIView  {
    
    fileprivate var refreshControl = UIRefreshControl()
    fileprivate var table: UITableView?
    var dataModel:DataModel? = nil
    var tableRowsDesc:TableRowsDesc? = nil
    weak var delegate: RefreshDataProtocol? = nil
    
    init(frame: CGRect, menuResourceId: String) {
        super.init(frame: frame)
        buildTable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     This method is used for making table view
     and also setting constraint in table View
     */
    fileprivate func buildTable() {
        table = UITableView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(frame.size.width), height: CGFloat(frame.size.height)), style: .plain)
        table?.register(ContainerTableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
         table?.dataSource = self
        if UIDevice.current.userInterfaceIdiom == .pad{
            table?.rowHeight = 150.0
        }else{
            table?.rowHeight = 140.0
        }
        table?.separatorStyle = .singleLine
        table?.allowsSelection = false
        addSubview(table!)
        
        table?.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: table!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: table!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        let  leftConstraint = NSLayoutConstraint(item: table!, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0)
        let  rightConstraint = NSLayoutConstraint(item: table!, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0)
        self.addConstraints([topConstraint, bottomConstraint, leftConstraint,rightConstraint])
        
        table?.backgroundColor = UIColor.clear
        refreshControl.attributedTitle = NSAttributedString(string: kRefreshContent)
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        table?.addSubview(refreshControl)
    }
    
    /*
     This method is used for receving model data from ContainerViewController
     after service Call and reloding ContainerTableView Data.
     */
    func getModelData(dataModel:DataModel){
        self.dataModel = dataModel
        table?.reloadData()
        endRefreshControl()
    }
    /*
     This method is used for taking refresh ContainerView Data
     and take updated data from server.
     */
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        if delegate != nil {
            delegate?.updateDataFromServer()
        }
    }
    /*
     This method is used for end refresh after fetching
     latest data from server.
     */
    func endRefreshControl() -> Void {
        refreshControl.endRefreshing()
    }
}
//MARK: - UITableViewDataSource
/*
 Created  extension for ContainerTableView for  writing TableView method seperately.
 */
extension ContainerTableView:UITableViewDataSource{
/*
     This is used for filling content in Cell and reusing same cell.
     If there is no image coming from server, Putting default image
     in Placeholder,Similarly doing for title and Description.
*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = kCellIdentifier
        var cell: ContainerTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ContainerTableViewCell
        cell = ContainerTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        if let item:TableRowsDesc = self.dataModel?.rows![indexPath.row] {
            
            if let title = item.title {
                cell.titleLabel.text = title
            } else {
                cell.titleLabel.text = kTTitleUnavialable
            }
            
            if let description =  item.description{
                cell.descLabel.text = description
            }  else {
                cell.descLabel.text = kDescUnavialable
                
            }
            
            if let imageUrl = item.imageHref{
                LazyImageLoad.setImageOnImageViewFromURL(imageView: (cell.cellImageView), url: imageUrl) { (image) in
                    if image == nil {
                        cell.cellImageView.image = UIImage(named: "NoImagePlaceholder")
                    } else {
                        cell.cellImageView.image = image
                    }
                }
            } else {
                cell.cellImageView.image = UIImage(named: "NoImagePlaceholder")
            }
        }
        
        return cell
        
    }
    /*
     This method return number of rows  in TableView
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.dataModel?.rows?.count{
            return count
        }else{
            return 1
        }
        
    }
    /*
     This method return number of Section in TableView
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
