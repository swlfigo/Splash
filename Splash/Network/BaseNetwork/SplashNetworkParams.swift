//
//  SplashNetworkParams.swift
//  Splash
//
//  Created by Sylar on 2020/5/19.
//  Copyright © 2020 Sylar. All rights reserved.
//

import Foundation

enum SplashNetworkingMethod : Int {
    case get = 0
    case post
    case delete
    case put
}

struct SplashNetworkingFetchParams {
    
    var urlString : String = ""
    var method : SplashNetworkingMethod = .get
    var params : [String:Any]?
    
}
