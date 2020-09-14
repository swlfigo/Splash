//
//  SplashMainViewController.swift
//  Splash
//
//  Created by Sylar on 2020/5/7.
//  Copyright © 2020 Sylar. All rights reserved.
//

import UIKit
import SnapKit
import CHTCollectionViewWaterfallLayout

class SplashMainViewController: UIViewController {
    
    let listVC = SplashListPhotosViewController.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        
        self.view.addSubview(listVC.view)
        self.addChild(listVC)
        listVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(0)
            make.width.bottom.equalToSuperview()
        }
        listVC.beginAppearanceTransition(true, animated: true)
        
    }
    


}
