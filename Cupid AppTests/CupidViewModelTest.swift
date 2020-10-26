//
//  CupidViewModelTest.swift
//  Cupid AppTests
//
//  Created by Ngay Vong on 10/26/20.
//

@testable import Cupid_App
import XCTest

class CupidViewModelTest: XCTestCase {

    var viewModel: CupidViewModel?
    
    override class func setUp() {
    }
    
    override func setUpWithError() throws {
        viewModel = CupidViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
