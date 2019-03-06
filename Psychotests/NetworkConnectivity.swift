//
//  NetworkConnectivity.swift
//  Psychotests
//
//  Created by Robert Nowiński on 06/03/2019.
//  Copyright © 2019 Robert Nowiński. All rights reserved.
//

import Foundation
import SystemConfiguration

class NetworkHelper {
    
    class func isConnectedNetwork () {
        var zeroAddress = sockaddr_in ()
        
        zeroAddress.sin_len = UInt8 (MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachablilty = withUnsafePointer(to: &zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
    }
}
