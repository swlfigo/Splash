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
        
        var httpHeader : [HTTPHeader] = []
        if let header = netParams.header {
            for (key , value) in header {
                let httpH = HTTPHeader.init(name: key, value: value)
                httpHeader.append(httpH)
            }
        }
        
        return AF.request(netParams.urlString, method: method, parameters: netParams.params, encoding: URLEncoding.default, headers: HTTPHeaders.init(httpHeader), interceptor: nil, requestModifier: nil).responseJSON { (response) in
            if response.value != nil {
                let result = SplashNetworkingResult.init(code: 200, message: response.description, responseData: response.data, object: response.value)
                if let complete = success{
                    complete(result)
                }
            }else{
                let result = SplashNetworkingResult.init(code: 404, message: response.description, responseData: nil, object: response.data)
                if let complete = fail{
                    complete(result)
                }
            }
        }
    }
}
