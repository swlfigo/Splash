//
//  SplashMainPageViewModel.swift
//  Splash
//
//  Created by Sylar on 2020/6/16.
//  Copyright © 2020 Sylar. All rights reserved.
//

import UIKit

class SplashMainPageViewModel: SplashPageViewModel {
    override func requestParameter() -> SplashNetworkingFetchParams {
        let fetchParams = SplashNetworkingFetchParams.init(urlString: "https://api.unsplash.com/photos", method: .get, params: ["per_page":30])
        return fetchParams
    }
}
