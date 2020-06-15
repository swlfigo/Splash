//
//  SplashNetworkingManager.swift
//  Splash
//
//  Created by Sylar on 2020/6/15.
//  Copyright © 2020 Sylar. All rights reserved.
//

import Foundation
import Alamofire

typealias SplashNetworkingFetchResultBlock = (_ result:SplashNetworkingResult) -> Void


class SplashNetworkingManager:NSObject{
    @discardableResult
    static func fetch(netParams:SplashNetworkingFetchParams , success:SplashNetworkingFetchResultBlock? , fail:SplashNetworkingFetchResultBlock?) -> DataRequest{
        var method = HTTPMethod.get
        switch netParams.method {
        case .get:
            method = .get
        case .post:
            method = .post
        case .delete:
            method = .delete
        case .put:
            method = .put
        }
        return AF.request(netParams.urlString, method: method, parameters: netParams.params, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            
        }
    }
}
