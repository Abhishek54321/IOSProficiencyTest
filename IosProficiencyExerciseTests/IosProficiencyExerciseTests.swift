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
    
    override func setUp() {
        super.setUp()
            datamodel = DataModel()
       // title = "About Canada"
        
        
    }
    
    override func tearDown() {
        homeViewModel = nil
        datamodel = nil
        super.tearDown()
        
    }
    
    func testData(){
        let expectation = XCTestExpectation(description: "Get data from server")
        ContainerViewModel.getAppList("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json", completion: {(data,sucess)
            in
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testServerData(){
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Get data from server")
        
        // Create a URL for a web page to be downloaded.
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        
        // Create a background task to download the web page.
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, _, _) in
            
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded.")
            //  XCTAssertNil(data, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
            
            
        }
        // Start the download task.
        dataTask.resume()
        
    }
    func testNetwork(){
        let bool = NWReachability.connectedToNetwork()
        XCTAssertTrue(bool, "Suceess")
        
    }
    func testNavBarTitle(){
     
        if let title = datamodel!.title{
             XCTAssertEqual(title, "About Canada")
        }
       
    }
    func testNumbersOfRow(){
        
        guard let tableRows = datamodel!.rows, let count = tableRows.count as? Int else{
           return
        }
       
        XCTAssertEqual(count, 14)
    }
    
   
    
}
