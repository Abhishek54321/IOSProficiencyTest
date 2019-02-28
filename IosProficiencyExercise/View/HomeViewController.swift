//
//  ViewController.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit
import SVProgressHUD
import Reachability

class HomeViewController: UIViewController {
    
    var table: ContainerView?
    var resourcemenuID:String = ""
    var resourceTitle:String = ""
    var dataModel:DataModel? = nil
    
    //MARK: - Viewcontroller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAppDataFromServer()
        self.buildTable()
        self.setupHeaderAndTitleLabel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if NWReachability.connectedToNetwork(){
              SVProgressHUD.show(withStatus: kDownloadData)
            print("Ineternet is there")
        }else{
            self.showNetworkAlert()
        }
    }
    //MARK: - Container View
    //This method is for making Container View
    func buildTable() {
        table = ContainerView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(100)), menuResourceId: resourcemenuID )
        table?.delegate = self
        PViewUtils.anchorView(table, top: 0, right: 0, bottom: 0, left: 0, in: view)
        view.addSubview(table!)
    }
    
    func setupHeaderAndTitleLabel() {
        if let navTitle = dataModel?.title{
            self.title = navTitle
        }
        
    }
    //MARK: - getAppDataFromServer
    //This method Get data from Server
    func getAppDataFromServer(){
        let urls = prodURL
        HomeViewModel.getAppList(urls){ (data,error)  in
            if data != nil {
                //self.showActivityIndicator(false)
                SVProgressHUD.dismiss()
                self.dataModel = data
                //For updating data in main Thread
                DispatchQueue.main.async {
                    self.setupHeaderAndTitleLabel()
                    self.table!.getModelData(dataModel: self.dataModel!)
                }
            }
        }
    }
    //MARK: - showNetworkAlert
    //This method show  Alert if network connection is not there
    func showNetworkAlert(){
        let alert = UIAlertController(title: kNoInternet, message: kNoInternetMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: kOK, style: .cancel, handler: { action in
            switch action.style{
            case .default:
                break
            case .cancel:
                self.dismiss(animated: true, completion: nil)
               
            case .destructive:
                 break
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: - RefreshDataProtocol
//This method take latest data from server
extension HomeViewController: RefreshDataProtocol {
    func updateDataFromServer() -> Void {
        getAppDataFromServer()
    }
}

