//
//  HomeTableView.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit

protocol RefreshDataProtocol : class {
    func updateDataFromServer() -> Void
}

class ContainerView: UIView  {
    
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
    
    fileprivate func buildTable() {
        table = UITableView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(frame.size.width), height: CGFloat(frame.size.height)), style: .plain)
        PViewUtils.anchorView(table, top: 0, right: 0.0, bottom: 0, left: 0.0, in: self)
        
        table?.dataSource = self
        if UIDevice.current.userInterfaceIdiom == .pad{
           table?.rowHeight = 150.0
        }else{
                table?.rowHeight = 140.0
        }
    
        table?.separatorStyle = .singleLine
        
        //table?.tableHeaderView = getHeader()
        table?.allowsSelection = false
        addSubview(table!)
        table?.backgroundColor = UIColor.clear
        
        refreshControl.attributedTitle = NSAttributedString(string: kRefreshContent)
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        table?.addSubview(refreshControl)
    }
    
    func getModelData(dataModel:DataModel){
        self.dataModel = dataModel
        table?.reloadData()
        endRefreshControl()
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        if delegate != nil {
            delegate?.updateDataFromServer()
        }
    }
    
    func endRefreshControl() -> Void {
        refreshControl.endRefreshing()
    }
}

extension ContainerView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier: String = kCellIdentifier
        var cell: HomeTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? HomeTableViewCell)
        if cell == nil {
            cell = HomeTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        if let item:TableRowsDesc = self.dataModel?.rows![indexPath.row] {
            
            if let title = item.title {
                cell?.titleLabel?.text = title
            } else {
                cell?.titleLabel?.text = kTTitleUnavialable
            }
            
            if let description =  item.description{
                cell?.descLabel?.text = description
            }  else {
                cell?.descLabel?.text = kDescUnavialable
            }
            
            if let imageUrl = item.imageHref{
                LazyImageLoad.setImageOnImageViewFromURL(imageView: (cell?.cellImageView)!, url: imageUrl) { (image) in
                    if image == nil {
                        cell?.cellImageView?.image = UIImage(named: "NoImagePlaceholder")
                    } else {
                        cell?.cellImageView?.image = image
                    }
                }
            } else {
                cell?.cellImageView?.image = UIImage(named: "NoImagePlaceholder")
            }
        }
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.dataModel?.rows?.count{
            return count
        }else{
            return 1
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
