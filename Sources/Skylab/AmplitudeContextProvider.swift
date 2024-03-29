//
//  AmplitudeContextProvider.swift
//  Skylab
//
//  Copyright © 2020 Amplitude. All rights reserved.
//

import Foundation

import Amplitude

public class AmplitudeContextProvider : ContextProvider {

    let amplitude: Amplitude
    var initialized: Bool
    var version: String?

    public init(_ amplitude:Amplitude) {
        self.amplitude = amplitude
        self.initialized = false
        self.version = nil
    }

    public func getDeviceId() -> String? {
        waitForAmplitudeInitialized()
        return self.amplitude.getDeviceId()
    }

    public func getUserId() -> String? {
        waitForAmplitudeInitialized()
        return self.amplitude.userId
    }

    func cacheVersion() -> Void {
        version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    public func getVersion() -> String? {
        return version
    }

    public func getLanguage() -> String? {
        Locale(identifier: "en_US").localizedString(forLanguageCode: Locale.preferredLanguages[0])
    }

    public func getPlatform() -> String? {
        return "iOS"
    }

    public func getOs() -> String? {
        let systemVersion = ProcessInfo.processInfo.operatingSystemVersion
        let os = "ios \(systemVersion.majorVersion).\(systemVersion.minorVersion).\(systemVersion.patchVersion)."
        return os
    }

    public func getDeviceManufacturer() -> String? {
        return "Apple"
    }

    func getPlatformString() -> String {
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }

    func getModelString() -> String? {
        let platform = getPlatformString()
        // == iPhone ==
        // iPhone 1
        if (platform == "iPhone1,1") { return "iPhone 1" }
        // iPhone 3
        if (platform == "iPhone1,2") { return "iPhone 3G" }
        if (platform == "iPhone2,1") { return "iPhone 3GS" }
        // iPhone 4
        if (platform == "iPhone3,1") { return "iPhone 4" }
        if (platform == "iPhone3,2") { return "iPhone 4" }
        if (platform == "iPhone3,3") { return "iPhone 4" }
        if (platform == "iPhone4,1") { return "iPhone 4S" }
        // iPhone 5
        if (platform == "iPhone5,1") { return "iPhone 5" }
        if (platform == "iPhone5,2") { return "iPhone 5" }
        if (platform == "iPhone5,3") { return "iPhone 5c" }
        if (platform == "iPhone5,4") { return "iPhone 5c" }
        if (platform == "iPhone6,1") { return "iPhone 5s" }
        if (platform == "iPhone6,2") { return "iPhone 5s" }
        // iPhone 6
        if (platform == "iPhone7,1") { return "iPhone 6 Plus" }
        if (platform == "iPhone7,2") { return "iPhone 6" }
        if (platform == "iPhone8,1") { return "iPhone 6s" }
        if (platform == "iPhone8,2") { return "iPhone 6s Plus" }

        // iPhone 7
        if (platform == "iPhone9,1") { return "iPhone 7" }
        if (platform == "iPhone9,2") { return "iPhone 7 Plus" }
        if (platform == "iPhone9,3") { return "iPhone 7" }
        if (platform == "iPhone9,4") { return "iPhone 7 Plus" }
        // iPhone 8
        if (platform == "iPhone10,1") { return "iPhone 8" }
        if (platform == "iPhone10,4") { return "iPhone 8" }
        if (platform == "iPhone10,2") { return "iPhone 8 Plus" }
        if (platform == "iPhone10,5") { return "iPhone 8 Plus" }

        // iPhone X
        if (platform == "iPhone10,3") { return "iPhone X" }
        if (platform == "iPhone10,6") { return "iPhone X" }

        // iPhone XS
        if (platform == "iPhone11,2") { return "iPhone XS" }
        if (platform == "iPhone11,6") { return "iPhone XS Max" }

        // iPhone XR
        if (platform == "iPhone11,8") { return "iPhone XR" }

        // iPhone 11
        if (platform == "iPhone12,1") { return "iPhone 11" }
        if (platform == "iPhone12,3") { return "iPhone 11 Pro" }
        if (platform == "iPhone12,5") { return "iPhone 11 Pro Max" }

        // iPhone SE
        if (platform == "iPhone8,4") { return "iPhone SE" }
        if (platform == "iPhone12,8") { return "iPhone SE 2" }

        // == iPod ==
        if (platform == "iPod1,1") { return "iPod Touch 1G" }
        if (platform == "iPod2,1") { return "iPod Touch 2G" }
        if (platform == "iPod3,1") { return "iPod Touch 3G" }
        if (platform == "iPod4,1") { return "iPod Touch 4G" }
        if (platform == "iPod5,1") { return "iPod Touch 5G" }
        if (platform == "iPod7,1") { return "iPod Touch 6G" }
        if (platform == "iPod9,1") { return "iPod Touch 7G" }

        // == iPad ==
        // iPad 1
        if (platform == "iPad1,1") { return "iPad 1" }
        // iPad 2
        if (platform == "iPad2,1") { return "iPad 2" }
        if (platform == "iPad2,2") { return "iPad 2" }
        if (platform == "iPad2,3") { return "iPad 2" }
        if (platform == "iPad2,4") { return "iPad 2" }
        // iPad 3
        if (platform == "iPad3,1") { return "iPad 3" }
        if (platform == "iPad3,2") { return "iPad 3" }
        if (platform == "iPad3,3") { return "iPad 3" }
        // iPad 4
        if (platform == "iPad3,4") { return "iPad 4" }
        if (platform == "iPad3,5") { return "iPad 4" }
        if (platform == "iPad3,6") { return "iPad 4" }
        // iPad Air
        if (platform == "iPad4,1") { return "iPad Air" }
        if (platform == "iPad4,2") { return "iPad Air" }
        if (platform == "iPad4,3") { return "iPad Air" }
        // iPad Air 2
        if (platform == "iPad5,3") { return "iPad Air 2" }
        if (platform == "iPad5,4") { return "iPad Air 2" }
        // iPad 5
        if (platform == "iPad6,11") { return "iPad 5" }
        if (platform == "iPad6,12") { return "iPad 5" }
        // iPad 6
        if (platform == "iPad7,5") { return "iPad 6" }
        if (platform == "iPad7,6") { return "iPad 6" }
        // iPad Air 3
        if (platform == "iPad11,3") { return "iPad Air 3" }
        if (platform == "iPad11,4") { return "iPad Air 3" }
        // iPad 7
        if (platform == "iPad7,11") { return "iPad 6" }
        if (platform == "iPad7,12") { return "iPad 6" }

        // iPad Pro
        if (platform == "iPad6,7") { return "iPad Pro" }
        if (platform == "iPad6,8") { return "iPad Pro" }
        if (platform == "iPad6,3") { return "iPad Pro" }
        if (platform == "iPad6,4") { return "iPad Pro" }
        if (platform == "iPad7,1") { return "iPad Pro" }
        if (platform == "iPad7,2") { return "iPad Pro" }
        if (platform == "iPad7,3") { return "iPad Pro" }
        if (platform == "iPad7,4") { return "iPad Pro" }
        if (platform == "iPad8,1") { return "iPad Pro" }
        if (platform == "iPad8,2") { return "iPad Pro" }
        if (platform == "iPad8,3") { return "iPad Pro" }
        if (platform == "iPad8,4") { return "iPad Pro" }
        if (platform == "iPad8,5") { return "iPad Pro" }
        if (platform == "iPad8,6") { return "iPad Pro" }
        if (platform == "iPad8,7") { return "iPad Pro" }
        if (platform == "iPad8,8") { return "iPad Pro" }

        // iPad Mini
        if (platform == "iPad2,5") { return "iPad Mini" }
        if (platform == "iPad2,6") { return "iPad Mini" }
        if (platform == "iPad2,7") { return "iPad Mini" }
        // iPad Mini 2
        if (platform == "iPad4,4") { return "iPad Mini 2" }
        if (platform == "iPad4,5") { return "iPad Mini 2" }
        if (platform == "iPad4,6") { return "iPad Mini 2" }
        // iPad Mini 3
        if (platform == "iPad4,7") { return "iPad Mini 3" }
        if (platform == "iPad4,8") { return "iPad Mini 3" }
        if (platform == "iPad4,9") { return "iPad Mini 3" }
        // iPad Mini 4
        if (platform == "iPad5,1") { return "iPad Mini 4" }
        if (platform == "iPad5,2") { return "iPad Mini 4" }
        // iPad Mini 5
        if (platform == "iPad11,1") { return "iPad Mini 5" }
        if (platform == "iPad11,2") { return "iPad Mini 5" }

        // == Apple Watch ==
        if (platform == "Watch1,1") { return "Apple Watch 38mm" }
        if (platform == "Watch1,2") { return "Apple Watch 42mm" }
        if (platform == "Watch2,3") { return "Apple Watch Series 2 38mm" }
        if (platform == "Watch2,4") { return "Apple Watch Series 2 42mm" }
        if (platform == "Watch2,6") { return "Apple Watch Series 1 38mm" }
        if (platform == "Watch2,7") { return "Apple Watch Series 1 42mm" }
        if (platform == "Watch3,1") { return "Apple Watch Series 3 38mm Cellular" }
        if (platform == "Watch3,2") { return "Apple Watch Series 3 42mm Cellular" }
        if (platform == "Watch3,3") { return "Apple Watch Series 3 38mm" }
        if (platform == "Watch3,4") { return "Apple Watch Series 3 42mm" }
        if (platform == "Watch4,1") { return "Apple Watch Series 4 40mm" }
        if (platform == "Watch4,2") { return "Apple Watch Series 4 44mm" }
        if (platform == "Watch4,3") { return "Apple Watch Series 4 40mm Cellular" }
        if (platform == "Watch4,4") { return "Apple Watch Series 4 44mm Cellular" }
        if (platform == "Watch5,1") { return "Apple Watch Series 5 40mm" }
        if (platform == "Watch5,2") { return "Apple Watch Series 5 44mm" }
        if (platform == "Watch5,3") { return "Apple Watch Series 5 40mm Cellular" }
        if (platform == "Watch5,4") { return "Apple Watch Series 5 44mm Cellular" }
        if (platform == "Watch6,1") { return "Apple Watch Series 6 40mm" }
        if (platform == "Watch6,2") { return "Apple Watch Series 6 44mm" }
        if (platform == "Watch6,3") { return "Apple Watch Series 6 40mm Cellular" }
        if (platform == "Watch6,4") { return "Apple Watch Series 6 44mm Cellular" }

        // == Others ==
        if (platform == "i386") { return "Simulator" }
        if (platform == "x86_64") { return "Simulator" }
        if (platform.hasPrefix("MacBookAir")) { return "MacBook Air" }
        if (platform.hasPrefix("MacBookPro")) { return "MacBook Pro" }
        if (platform.hasPrefix("MacBook")) { return "MacBook" }
        if (platform.hasPrefix("MacPro")) { return "Mac Pro" }
        if (platform.hasPrefix("Macmini")) { return "Mac Mini" }
        if (platform.hasPrefix("iMac")) { return "iMac" }
        if (platform.hasPrefix("Xserve")) { return "Xserve" }
        return platform
    }

    public func getDeviceModel() -> String? {
        return getModelString()
    }

    func waitForAmplitudeInitialized() -> Void {
        if (initialized) {
            return
        }
        let start = CFAbsoluteTimeGetCurrent()
        while (self.amplitude.getDeviceId() as String? == nil) {
            Thread.sleep(forTimeInterval: 0.02)
        }
        initialized = true
        let end = CFAbsoluteTimeGetCurrent()
        print("[Skylab] Waited \(end - start)s for Amplitude SDK initialization")
    }
}
