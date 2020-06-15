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
    
    
    func loadModels<T: Decodable>(reload:Bool, success:@escaping(_ model:[T] , _ result : SplashNetworkingResult) -> Void, fail:SplashViewModelFailBlock) -> Void {
        
        
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
        
        
        
        
    }
}


extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
