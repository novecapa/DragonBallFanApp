//
//  Utils.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation
import SystemConfiguration

protocol UtilsProtocol {
    var existsConnection: Bool { get }
    var appVersion: String { get }
}

final class Utils: UtilsProtocol {

    enum Constants {
        static let shortVersion = "CFBundleShortVersionString"
        static let bundleVersion = "CFBundleVersion"
        static let noVersion = "0.0.0"
    }

    var existsConnection: Bool {
        Reachability.isConnectedToNetwork()
    }

    var appVersion: String {
        guard let shortVersion = Bundle.main.infoDictionary?[Constants.shortVersion] as? String,
              let bundleVersion = Bundle.main.infoDictionary?[Constants.bundleVersion] as? String else {
            return Constants.noVersion
        }
        return "V. \(shortVersion) (\(bundleVersion))"
    }
}

// MARK: - Reachability

private final class Reachability {
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0,
                                      sin_family: 0,
                                      sin_port: 0,
                                      sin_addr: in_addr(s_addr: 0),
                                      sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
}
