//
//  SplashMainViewController.swift
//  Splash
//
//  Created by Sylar on 2020/5/7.
//  Copyright © 2020 Sylar. All rights reserved.
//

import UIKit

class SplashMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vm = SplashMainPageViewModel()
        vm.loadModels(reload: true, success: { (newModels:[SplashMainModel], SplashNetworkingResult) in
            print("Success")
        }) { (String, SplashNetworkingResult) in
            print("Fail")
        }
        
        
    }
    


}
