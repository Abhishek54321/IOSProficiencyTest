//
//  IosProficiencyExerciseTests.swift
//  IosProficiencyExerciseTests
//
//  Created by Abhishek Singh on 28/02/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import XCTest

class IosProficiencyExerciseTests: XCTestCase {
    var title :String?=nil
    override func setUp() {
        //var dataModel = DataModel
    //dataModel.title = "About Canada"
        title = "About Canada"
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
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

}
