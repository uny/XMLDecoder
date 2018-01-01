//
//  XMLDecoderTests.swift
//  XMLDecoderTests
//
//  Created by Yuki Nagai on 2017/12/17.
//

import XCTest
@testable import XMLDecoder

final class XMLDecoderTests: XCTestCase {
    func testArray() {
        let string = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
            + "<menu><foods><food><name>Belgian Waffles</name><price>5.95</price></food>"
            + "<food><name>Strawberry Belgian Waffles</name><price>7.95</price></food></foods></menu>"
        let data = string.data(using: .utf8)!
        let decoder = XMLDecoder()
        do {
            let menu = try decoder.decode(Menu.self, from: data)
            XCTAssertEqual(menu.foods.count, 2)
            XCTAssertEqual(menu.foods.first?.name, "Belgian Waffles")
            XCTAssertEqual(menu.foods.first?.price, 5.95)
            XCTAssertEqual(menu.foods.last?.name, "Strawberry Belgian Waffles")
            XCTAssertEqual(menu.foods.last?.price, 7.95)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testPascalCaseKeys() {
        let string = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
            + "<Root><URL>https://github.com</URL><URLString>https://github.com</URLString>"
            + "<Capitalized>https://github.com</Capitalized><lowercased>https://github.com</lowercased></Root>"
        let data = string.data(using: .utf8)!
        let decoder = XMLDecoder()
        decoder.keyDecodingStrategy = .convertFromPascalCase
        do {
            let root = try decoder.decode(PascalCaseKeys.self, from: data)
            XCTAssertEqual(root.url, URL(string: "https://github.com"))
            XCTAssertEqual(root.urlString, "https://github.com")
            XCTAssertEqual(root.capitalized, "https://github.com")
            XCTAssertEqual(root.lowercased, "https://github.com")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testNumberValues() {
        let string = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
            + "<root><int>-128</int><int8>-8</int8><int16>-16</int16><int32>-32</int32><int64>-64</int64>"
            + "<uint>128</uint><uint8>8</uint8><uint16>16</uint16><uint32>32</uint32><uint64>64</uint64>"
            + "<float>3.14</float><double>3.14</double></root>"
        let data = string.data(using: .utf8)!
        let decoder = XMLDecoder()
        do {
            let root = try decoder.decode(NumberValues.self, from: data)
            XCTAssertEqual(root.int, -128)
            XCTAssertEqual(root.int8, -8)
            XCTAssertEqual(root.int16, -16)
            XCTAssertEqual(root.int32, -32)
            XCTAssertEqual(root.int64, -64)
            XCTAssertEqual(root.uint, 128)
            XCTAssertEqual(root.uint8, 8)
            XCTAssertEqual(root.uint16, 16)
            XCTAssertEqual(root.uint32, 32)
            XCTAssertEqual(root.uint64, 64)
            XCTAssertEqual(root.float, 3.14)
            XCTAssertEqual(root.double, 3.14)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    // MARK: - Nested Objects
    private struct Menu: Decodable {
        let foods: [Food]
        
        struct Food: Decodable {
            let name: String
            let price: Double
        }
    }
    
    private struct PascalCaseKeys: Decodable {
        let url: URL
        let urlString: String
        let capitalized: String
        let lowercased: String
    }
    
    private struct NumberValues: Decodable {
        let int: Int
        let int8: Int8
        let int16: Int16
        let int32: Int32
        let int64: Int64
        let uint: UInt
        let uint8: UInt8
        let uint16: UInt16
        let uint32: UInt32
        let uint64: UInt64
        let float: Float
        let double: Double
    }
}
