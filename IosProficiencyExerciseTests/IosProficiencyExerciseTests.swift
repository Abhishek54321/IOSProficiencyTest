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
    var homeViewModel:HomeViewModel?
    
    override func setUp() {
        super.setUp()

        title = "About Canada"
     
    }

    override func tearDown() {
        homeViewModel = nil
        super.tearDown()
       
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
    
    func testNavBarTitle(){
        XCTAssertEqual(title, "About Canada")
    }
    
    
    func test_fetch_details(){
      //  let homeModel = self.homeViewModel!
//        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
//        let result = XCTestExpectation(description: "call")
//        HomeViewModel.getAppList(url) { (data, 200) in
//            data.
//        }
       
        
    }

}
