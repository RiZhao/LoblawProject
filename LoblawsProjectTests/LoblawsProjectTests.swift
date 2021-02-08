//
//  LoblawsProjectTests.swift
//  LoblawsProjectTests
//
//  Created by Bill Zhao on 2021-02-07.
//

import XCTest
@testable import LoblawsProject

class LoblawsProjectTests: XCTestCase {
    
    func testModel() throws {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "items", ofType: "json") else { fatalError("Can't find search.json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let response = try JSONDecoder().decode(LPCart.self, from: data)
        
        XCTAssertEqual(response.entries.count, 6)

        let repo = response.entries.first
        
        XCTAssertEqual(repo?.code, "062600300751")
        XCTAssertEqual(repo?.image, "https://assets.beauty.shoppersdrugmart.ca/bb-prod-product-image/062600300751/enfr/01/front/400/white.jpg")
        XCTAssertEqual(repo?.name, "RAPID CLEAR® Spot Gel")
        XCTAssertEqual(repo?.price, "$11.99")
        XCTAssertEqual(repo?.type, LPCartItem.ItemType.beautyFace)
    }
}
