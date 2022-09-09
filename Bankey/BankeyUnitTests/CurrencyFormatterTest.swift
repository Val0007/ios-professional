//
//  CurrencyFormatterTest.swift
//  BankeyUnitTests
//
//  Created by Val V on 09/09/22.
//

import Foundation
import XCTest

@testable import Bankey //imports all files from our app

class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() { //gets run every time test runs
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    
    func testDollorFormatter() throws {
        let r = formatter.dollarsFormatted(929466)
        XCTAssertEqual(r, "$929,466.00")
    }
    
}
