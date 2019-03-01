//
//  ViewController.swift
//  IosProficiencyExercise
//
//  Created by Abhishek Singh on 26/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.

import UIKit
import SVProgressHUD


class ContainerViewController: UIViewController {
    
    var containerTableView: ContainerTableView?
    var resourcemenuID:String = ""
    var resourceTitle:String = ""
    var dataModel:DataModel? = nil
    
    //MARK: - Viewcontroller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAppDataFromServer()
        self.buildContainerTableView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
     self.checkNetWorkConnectivity()
    }
    
/*
     This method is used for checking network
     connectivity and showing Progress bar if
     network is there otherwise showNetwork
     Alert message.
 
 */
    func  checkNetWorkConnectivity(){
        if NWReachability.connectedToNetwork(){
            //showing Progress bar
            SVProgressHUD.show(withStatus: kDownloadData)
            
        }else{
            self.showNetworkAlert()
        }
    }
    //MARK: - Container View
/*
     This method is mainly used for making container View in ContainerViewController.
     and added constraint.
     
 */
    func buildContainerTableView() {
        containerTableView = ContainerTableView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(view.frame.size.width), height: CGFloat(100)), menuResourceId: resourcemenuID )
        view.addSubview(containerTableView!)
        containerTableView?.translatesAutoresizingMaskIntoConstraints = false
        containerTableView?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerTableView?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        containerTableView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerTableView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }
/*
 This method  is used for setting title
     in navigation bar.
     
 */
    func setupHeaderAndTitleLabel() {
        if let navTitle = dataModel?.title{
            self.title = navTitle
        }
        
    }
    //MARK: - getAppDataFromServer
 /*
   This method used for getting data from
     server and after getting data from server
     passed it ContainerTableView .Also setting title
     in Navigation bar of ContainerViewController.
 */
    func getAppDataFromServer(){
        let urls = prodURL
        ContainerViewModel.getAppList(urls){ (data,error)  in
            if data != nil {
                SVProgressHUD.dismiss()
                self.dataModel = data
                //For updating data in main Thread
                DispatchQueue.main.async {
                    self.setupHeaderAndTitleLabel()
                    self.containerTableView!.getModelData(dataModel: self.dataModel!)
                }
            }
        }
    }
    //MARK: - showNetworkAlert
   /*
     This method is used for showing Network Alert.
     If network is not there,its shows alert message.
 */
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
/*
 This method is used for taking updated data from server
 */
extension ContainerViewController: RefreshDataProtocol {
    func updateDataFromServer() -> Void {
        getAppDataFromServer()
    }
}

