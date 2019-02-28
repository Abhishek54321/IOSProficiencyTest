/** -------------------------------------------------------------
 * Copyright (C) 2017 Redken, Inc. All trade marks registered
 *
 * This file is part of Redken Style Station Mobile Project.
 *
 * Redken Style Station Mobile Project can not be copied and/or
 *
 * distributed without the express permission of Redken, Inc.
 *
 * -------------------------------------------------------------
 **/
import Foundation
import SystemConfiguration
import CoreTelephony

public class NWReachability{
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
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
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
        
    }
    
    class func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                
                SCNetworkReachabilityCreateWithAddress(nil, $0)
                
            }
            
        }) else {
            
            return false
        }
        var flags : SCNetworkReachabilityFlags = []
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            
            return false
            
        }
        
        let isReachable = flags.contains(.reachable)
        
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
        
    }
    
    class func getTimeoutValue() -> TimeInterval{
        // Check for 3G
        // Setup the Network Info and create a CTCarrier object
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
            else
        {
            return getTimeoutValue()
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            return getTimeoutValue()
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let isWWAN = flags.contains(.isWWAN)
        
        if !needsConnection && isReachable {
            if isWWAN {
                let networkInfo = CTTelephonyNetworkInfo()
                
                if networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyGPRS ||
                    networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyEdge ||
                    networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyEdge ||
                    networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyCDMA1x {
                    return timeoutValueFor2G
                }else if networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyWCDMA ||
                    networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyHSDPA ||
                    networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyHSUPA ||
                    networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyCDMAEVDORev0 ||
                    networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyCDMAEVDORevA ||
                    networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyCDMAEVDORevB ||
                    networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyeHRPD{
                    return timeoutValueFor3G
                }else if networkInfo.currentRadioAccessTechnology == CTRadioAccessTechnologyLTE{
                    return timeoutValueFor4G
                }
            } else {
                return timeoutValueForWiFi
            }
        }
        
        return getTimeoutValue()
    }
}
