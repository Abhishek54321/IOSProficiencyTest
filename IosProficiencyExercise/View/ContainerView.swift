//
//  HomeTableView.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit

class ContainerView: UIView  {
    
  fileprivate var table: UITableView?
    var dataModel:DataModel? = nil
    var tableRowsDesc:TableRowsDesc? = nil
    
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
        table?.rowHeight = 130.0
        table?.separatorStyle = .singleLine
    
        //table?.tableHeaderView = getHeader()
        table?.allowsSelection = false
        addSubview(table!)
        table?.backgroundColor = UIColor.clear
    }
  
    func getModelData(dataModel:DataModel){
        self.dataModel = dataModel
        table?.reloadData()
      
    }

}

 extension ContainerView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cellIdentifier: String = "HomeTableViewCell"
        var cell: HomeTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? HomeTableViewCell)
        if cell == nil {
            cell = HomeTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        if let item:TableRowsDesc = self.dataModel?.rows![indexPath.row] {
            
            if let title = item.title {
                cell?.titleLabel?.text = title
            } else {
                cell?.titleLabel?.text = "Title Not Available"
            }
            
            if let description =  item.description{
               cell?.descLabel?.text = description
            }  else {
                cell?.descLabel?.text = "Desc Not Available"
            }
            
            if let imageUrl = item.imageHref{
                LazyImageLoad.setImageOnImageViewFromURL(imageView: (cell?.cellImageView)!, url: imageUrl) { (image) in
                    if image == nil {
                        cell?.cellImageView?.image = UIImage(named: "download")
                    } else {
                        cell?.cellImageView?.image = image
                    }
                }
            } else {
                cell?.cellImageView?.image = UIImage(named: "download")
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
