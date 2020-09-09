//
//  SplashMainViewController.swift
//  Splash
//
//  Created by Sylar on 2020/5/7.
//  Copyright © 2020 Sylar. All rights reserved.
//

import UIKit


class SplashMainViewController: UIViewController {
    
    let listVC = SplashListPhotosViewController.init()
    let topPager = SplashMainImagePagerView.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(topPager)
        topPager.snp.makeConstraints { (make) in
            make.width.top.equalToSuperview()
            make.height.equalTo(263)
        }
        topPager.getRandomPhoto()
        
        self.view.addSubview(listVC.view)
        self.addChild(listVC)
        listVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(topPager.snp.bottom).offset(0)
            make.width.bottom.equalToSuperview()
        }
        listVC.beginAppearanceTransition(true, animated: true)
        
    }
    


}
