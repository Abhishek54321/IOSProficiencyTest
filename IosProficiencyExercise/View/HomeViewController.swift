//
//  ViewController.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
    var table: ContainerView?
    var resourcemenuID:String = ""
    var resourceTitle:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildTable()
        self.setupHeaderAndTitleLabel()
      
    }

    func buildTable() {
        
        table = ContainerView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(100)), menuResourceId: resourcemenuID )
        PViewUtils.anchorView(table, top: 0, right: 0, bottom: 0, left: 0, in: view)
        view.addSubview(table!)
    }
    
    func setupHeaderAndTitleLabel() {
        self.title = "Hello Nav"
    }

}

