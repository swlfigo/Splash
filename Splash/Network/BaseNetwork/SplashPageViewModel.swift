//
//  SplashPageViewModel.swift
//  Splash
//
//  Created by Sylar on 2020/5/20.
//  Copyright © 2020 Sylar. All rights reserved.
//

import Foundation

class SplashPageViewModel: SplashViewModel {
    
    var pageIndex: Int = 0
    var pageModels: [Any] = []
    
    func loadModels<T: Decodable>(reload:Bool, success:@escaping(_ model:[T] , _ result : SplashNetworkingResult) -> Void, fail:@escaping (SplashViewModelFailBlock)) -> Void {
        
        
        if let operation = self.operation {
            operation.cancel()
        }
        
        var param = requestParameter()
        var otherParam: [String:Any] = [:]
        
        if let areadyOtherParam = param.params {
            otherParam.update(other: areadyOtherParam)
        }
        
        var pageIndex = 1
        
        if reload == false {
            pageIndex = self.pageIndex + 1
        }
        otherParam.updateValue(pageIndex, forKey: "page")
        
        param.params = otherParam
        
        
        var otherHeader : [String:String] = [:]
        otherHeader.update(other: authorizationHeader)
        
        param.header = otherHeader
        
        
        self.operation = SplashNetworkingManager.fetch(netParams: param, success: { (networkingResult) in
            
            var models :[T] = []
            
            if let data = networkingResult.responseData{
                let decodedModel = self.typeModels(type: [T].self, jsonData: data)
                
                for model in decodedModel ?? [] {
                    if let element = model as? T {
                        models.append(element)
                    }
                }
            }
            
            if reload == true{
                self.pageModels = models
            }else{
                self.pageModels.append(models)
            }
            
            success(models,networkingResult)
            
        }, fail: { (networkingResult) in
            
            fail(networkingResult.message ?? "msg of error was returned nil😲" , networkingResult)
            
        })
        
        
    }
}


extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
