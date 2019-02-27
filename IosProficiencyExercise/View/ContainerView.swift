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
        table?.rowHeight = 95.0
        table?.separatorStyle = .none
        //table?.tableHeaderView = getHeader()
        table?.allowsSelection = false
        addSubview(table!)
        table?.backgroundColor = UIColor.clear
    }


}

 extension ContainerView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CellIdentifier: String = "HomeTableViewCell"
        var cell: HomeTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? HomeTableViewCell)
        if cell == nil {
            cell = HomeTableViewCell(style: .default, reuseIdentifier: CellIdentifier)
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
