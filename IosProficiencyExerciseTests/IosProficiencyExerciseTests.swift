//
//  IosProficiencyExerciseTests.swift
//  IosProficiencyExerciseTests
//
//  Created by Abhishek Singh on 28/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import XCTest
@testable import IosProficiencyExercise
class IosProficiencyExerciseTests: XCTestCase {
    var title :String?
    var homeViewModel:ContainerViewModel?
    var datamodel:DataModel?
    //Mark: - Testing LifeCycle
    /*
     Here Setting initial Value and creating instance which is used for testing
     */
    override func setUp() {
        super.setUp()
            datamodel = DataModel()
       
    }
    /*
     This method execute after running test cases
     Here setting nil value to instances
     
    */
    override func tearDown() {
        homeViewModel = nil
        datamodel = nil
        super.tearDown()
        
    }
    //Mark: -testServerData
    //This method check data coming from server or not
    func testServerData(){
        let expectation = XCTestExpectation(description: "Get data from server")
        ContainerViewModel.getAppList("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", completion: {(data,sucess)
            in
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }
    
    /*
     This method is used for checking network avialablity is there or not
     */
   
    func testNetworkAvialability(){
        let bool = NWReachability.connectedToNetwork()
        XCTAssertTrue(bool, "Suceess")
        
    }
    
    /*
     This method is used for Testing navigation bar Title of ContainerViewController.
     */
    func testNavBarTitle(){
     
        if let title = datamodel!.title{
             XCTAssertEqual(title, "About Canada")
        }
       
    }
    /*
    This method is used for Testing number of rows in ContainerTableView
    */
    func testNumbersOfRowOfContainerTableView(){
        
        guard let tableRows = datamodel!.rows, let count = tableRows.count as? Int else{
           return
        }
       
        XCTAssertEqual(count, 14)
    }
    
   
    
}
