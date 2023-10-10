//
//  TestKATATests.swift
//  TestKATATests
//
//  Created by Moez bachagha on 8/10/2023.
//

import XCTest
@testable import TestKATA

final class TestKATATests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testGettingCitiesWithMockEmptyResult() {
        let expectation = expectation(description: "testing empty state with mock api")

        let mockAPI = MockCityAPI()
        mockAPI.loadState = .empty

        let viewModel = CitiesViewModel(apiService: mockAPI)
        viewModel.getCityDetails(lon:  10.0, lat:  10.0,
                                 completion: { cities, error in
            XCTAssertTrue(cities?.isEmpty == true, "Expected cities to be empty, but received some values")
            expectation.fulfill()
        })

        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }

    func testGettingCitiesWithErrorResult() {
        let expectation = expectation(description: "testing error state with mock api")

        let mockAPI = MockCityAPI()
        mockAPI.loadState = .error

        let viewModel = CitiesViewModel(apiService: mockAPI)
        viewModel.getCityDetails(lon:  10.0, lat:  10.0,
                                 completion: { cities, error in
            XCTAssertTrue(cities == nil, "Expected to get no cities and error, but received schools")
            XCTAssertNotNil(error, "Expected to get an error, but received no error")

            expectation.fulfill()
        })

        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }

    func testGettingCitiesWithSuccess() {
        let expectation = expectation(description: "testing success state with mock api")
        let mockAPI = MockCityAPI()
        mockAPI.loadState = .loaded

        let viewModel = CitiesViewModel(apiService: mockAPI)
        viewModel.getCityDetails(lon:  10.0, lat:  10.0,
                                 completion: { cities, error in
            XCTAssert(cities?.isEmpty == false, "Expected to get cities")
            XCTAssertNil(error, "Expected error to be nil")
            expectation.fulfill()
        })

        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
}
