//
//  Expo1900Tests.swift
//  Expo1900Tests
//
//  Created by 강인희 on 2021/05/17.
//

import XCTest
@testable import Expo1900

class Expo1900Tests: XCTestCase {
    private var sut: ExpositionInformation!
    private var sut2: ExpositionInformation!
    private var sut3: ExpositionInformation!
    
    override func setUpWithError() throws {
        super.setUp()
        let data = try getData(from: "exposition_universelle_1900")
        let noKeydata = try getData(from: "exposition_universelle_1900_NoTitleKey")
        let nullValuedata = try getData(from: "exposition_universelle_1900_NullTitleValue")
        sut = try JSONDecoder().decode(ExpositionInformation.self, from: data)
        sut2 = try JSONDecoder().decode(ExpositionInformation.self, from: noKeydata)
        sut3 = try JSONDecoder().decode(ExpositionInformation.self, from: nullValuedata)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
    
    func test_ExpositionInformation_JSONMapping() throws {
        XCTAssertEqual(sut.title, "파리 만국박람회")
        XCTAssertEqual(sut.visitors, 48130300)
    }
    
    func test_ExpositionInformation_JSONMapping_withNoTitle() throws {
        XCTAssertEqual(sut2.title, "")
    }
    
    func test_ExpositionInformation_JSONMapping_withNoTitleValue() throws {
        XCTAssertEqual(sut3.title, "")
    }
    
}
extension XCTestCase {
    func getData(from JSONFileName: String) throws -> Data {
        guard let asset = NSDataAsset(name: JSONFileName) else {
            fatalError("Can not found data asset.")
        }
        
        return asset.data
    }
}
