//
//  SkylabUserTest.swift
//  SkylabTests
//
//  Created by Brian Giori on 5/5/21.
//

import XCTest
@testable import Skylab

class SkylabUserTests: XCTestCase {

    func testSkylabUserJSONSerialization() {
        let user = SkylabUser(
            deviceId: "device_id",
            userId: "user_id",
            version: nil,
            country: "country",
            userProperties: ["userPropertyKey": "value"]
        )
        let expectedDictionary: [String : Any] = [
            "user_id": "user_id",
            "device_id": "device_id",
            "country": "country",
            "user_properties": [
                "userPropertyKey": "value"
            ]
        ]

        let userData = try! JSONSerialization.data(withJSONObject: user.toDictionary(), options: [])
        let expectedData = try! JSONSerialization.data(withJSONObject: expectedDictionary, options: [])

        let userAnyObject = try! JSONSerialization.jsonObject(with: userData, options: [])
        let expectedAnyObject = try! JSONSerialization.jsonObject(with: expectedData, options: [])

        let userDict = userAnyObject as! [String:Any]
        let expectedDict = expectedAnyObject as! [String:Any]

        let userUserDict = userDict["user_properties"] as! [String:String]
        let expectedUserDict = userDict["user_properties"] as! [String:String]

        XCTAssert(userDict["user_id"] as! String == expectedDict["user_id"] as! String)
        XCTAssert(userDict["device_id"] as! String == expectedDict["device_id"] as! String)
        XCTAssert(userDict["country"] as! String == expectedDict["country"] as! String)
        XCTAssert(userUserDict == expectedUserDict)
    }

    func testSkylabUserEquality() {
        let user = SkylabUser(
            deviceId: "device_id",
            userId: "user_id",
            version: nil,
            country: "country",
            userProperties: ["userPropertyKey": "value"]
        )
        let user2 = SkylabUser(
            deviceId: "device_id",
            userId: "user_id",
            version: nil,
            country: "country",
            userProperties: ["userPropertyKey": "different value"]
        )
        let user3 = SkylabUser(
            deviceId: "device_id",
            userId: "user_id",
            version: nil,
            country: "country",
            userProperties: ["userPropertyKey": "value"]
        )
        XCTAssert(user != user2)
        XCTAssert(user == user3)
    }

    func testSkylabUserContextProviderMerge() {
        let user = SkylabUser(
            deviceId: "",
            userId: nil,
            version: "version"
        )
        let mergedUser = SkylabUser(user: user, contextProvider: TestContextProvider())
        let expectedUserAfterMerge = SkylabUser(
            deviceId: "device_id",
            userId: "user_id",
            version: "version",
            language: "language"
        )
        print(mergedUser)
        print(expectedUserAfterMerge)
        XCTAssert(mergedUser == expectedUserAfterMerge)
    }
}

class TestContextProvider : ContextProvider {
    func getDeviceId() -> String? {
        return "device_id"
    }
    func getUserId() -> String? {
        return "user_id"
    }
    func getVersion() -> String? {
        return nil
    }
    func getLanguage() -> String? {
        return "language"
    }
    func getPlatform() -> String? {
        return nil
    }
    func getOs() -> String? {
        return nil
    }
    func getDeviceManufacturer() -> String? {
        return nil
    }
    func getDeviceModel() -> String? {
        return nil
    }
}
