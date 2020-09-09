//
//  SplashMainImagePagerPageViewModel.swift
//  Splash
//
//  Created by Sylar on 2020/9/9.
//  Copyright © 2020 Sylar. All rights reserved.
//

import UIKit

class SplashMainImagePagerPageViewModel: SplashPageViewModel {
    override func requestParameter() -> SplashNetworkingFetchParams {
        return SplashNetworkingFetchParams.init(urlString: "https://api.unsplash.com/photos/random", method: .get, params: ["count":10])
    }
}
