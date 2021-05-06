//
//  SkylabUser.swift
//  Skylab
//
//  Copyright © 2020 Amplitude. All rights reserved.
//

import Foundation

public struct SkylabUser: Equatable {
    public private(set) var deviceId: String?
    public private(set) var userId: String?
    public private(set) var version: String?
    public private(set) var country: String?
    public private(set) var region: String?
    public private(set) var dma: String?
    public private(set) var city: String?
    public private(set) var language: String?
    public private(set) var platform: String?
    public private(set) var os: String?
    public private(set) var deviceFamily: String?
    public private(set) var deviceType: String?
    public private(set) var deviceManufacturer: String?
    public private(set) var deviceModel: String?
    public private(set) var carrier: String?
    public private(set) var library: String?
    public private(set) var userProperties: [String: String]?

    public init(
        deviceId: String? = nil,
        userId: String? = nil,
        version: String? = nil,
        country: String? = nil,
        region: String? = nil,
        dma: String? = nil,
        city: String? = nil,
        language: String? = nil,
        platform: String? = nil,
        os: String? = nil,
        deviceFamily: String? = nil,
        deviceType: String? = nil,
        deviceManufacturer: String? = nil,
        deviceModel: String? = nil,
        carrier: String? = nil,
        library: String? = nil,
        userProperties: [String: String]? = nil
    ) {
        self.deviceId = deviceId
        self.userId = userId
        self.version = version
        self.country = country
        self.region = region
        self.dma = dma
        self.city = city
        self.language = language
        self.platform = platform
        self.os = os
        self.deviceFamily = deviceFamily
        self.deviceType = deviceType
        self.deviceManufacturer = deviceManufacturer
        self.deviceModel = deviceModel
        self.carrier = carrier
        self.library = library
        self.userProperties = userProperties
    }

    init(user: SkylabUser?, contextProvider: ContextProvider?) {
        self = user ?? SkylabUser()
        if contextProvider != nil {
            if let deviceId = contextProvider?.getDeviceId(), deviceId != "" {
                self.deviceId = deviceId
            }
            if let userId = contextProvider?.getUserId(), userId != "" {
                self.userId = userId
            }
            if let platform = contextProvider?.getPlatform() {
                self.platform = platform
            }
            if let version = contextProvider?.getVersion() {
                self.version = version
            }
            if let language = contextProvider?.getLanguage() {
                self.language = language
            }
            if let os = contextProvider?.getOs() {
                self.os = os
            }
            if let deviceManufacturer = contextProvider?.getDeviceManufacturer() {
                self.deviceManufacturer = deviceManufacturer
            }
            if let deviceModel = contextProvider?.getDeviceModel() {
                self.deviceModel = deviceModel
            }
        }
        // TODO: - Android does this: "skylab-android/" + BuildConfig.VERSION_NAME
    }

    public func toDictionary() -> [String:Any] {
        var data = [String:Any]()
        data["device_id"] = self.deviceId
        data["user_id"] = self.userId
        data["version"] = self.version
        data["country"] = self.country
        data["region"] = self.region
        data["dma"] = self.dma
        data["city"] = self.city
        data["language"] = self.language
        data["platform"] = self.platform
        data["os"] = self.os
        data["device_family"] = self.deviceFamily
        data["device_type"] = self.deviceType
        data["device_manufacturer"] = self.deviceManufacturer
        data["device_model"] = self.deviceModel
        data["carrier"] = self.carrier
        data["library"] = self.library
        data["user_properties"] = self.userProperties
        return data
    }
}
