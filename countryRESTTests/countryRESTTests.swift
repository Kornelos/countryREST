//
//  countryRESTTests.swift
//  countryRESTTests
//
//  Created by Kornel on 02/05/2019.
//  Copyright © 2019 Kornel. All rights reserved.
//

import XCTest
@testable import countryREST

class countryRESTTests: XCTestCase {

    var networkingManager: NetworkingManager!
    var namesModel: CountryNamesModel!
    var detailModel: CountryDetailModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkingManager = NetworkingManager()
        namesModel = CountryNamesModel()
        detailModel = CountryDetailModel(name: "", alpha3Code: "", capital: "", region: "", subregion: "", population: 0, latlng: [0.0,1.0], area: 2.0, timezones: [""], nativeName: "", currencies: [Currency(code: "", name: "", symbol: "")], languages: [], flag: "")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkingManager = nil
        namesModel = nil
        detailModel = nil
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

}
