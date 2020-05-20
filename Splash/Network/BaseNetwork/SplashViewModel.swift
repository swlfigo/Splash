//
//  SplashViewModel.swift
//  Splash
//
//  Created by Sylar on 2020/5/20.
//  Copyright © 2020 Sylar. All rights reserved.
//

import Foundation
import Alamofire

typealias SplashViewModelSuccessBlock = (_ newModels : [Any]? , _ result : SplashNetworkingResult) -> Void
typealias SplashViewModelFailBlock = (_ errorMessage : String , _ result : SplashNetworkingResult) -> Void
typealias SplashObjectModelSuccessBlock = (_ model : Any?,_ result : SplashNetworkingResult) -> Void


class SplashViewModel {
    var operation : DataRequest?
    
    func requestParameter() -> SplashNetworkingFetchParams{
        return SplashNetworkingFetchParams()
    }
    
    func cancel()->Void{
        self.operation?.cancel()
    }
    
    @discardableResult
    func model(withJsonData:Data) -> Any {
        return NSObject()
    }
    
    @discardableResult
    func typeModel<T: Decodable>(type: T.Type, jsonData: Data) -> Any? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(type, from: jsonData)
            return decodedData
            
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    
    @discardableResult
       func typeModels<T: Decodable>(type: T.Type, jsonData: Data) -> [Any]? {
           do {
               let decoder = JSONDecoder()
               let decodedData = try decoder.decode(type, from: jsonData)
               return decodedData as? [Any]
           } catch let error {
               print(error)
           }
           return nil
       }
}
