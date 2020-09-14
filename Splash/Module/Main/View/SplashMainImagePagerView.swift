//
//  SplashMainImagePagerView.swift
//  Splash
//
//  Created by Sylar on 2020/9/9.
//  Copyright © 2020 Sylar. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class SplashMainImagePagerView : UIView{
    let vm = SplashMainImagePagerPageViewModel.init()
    
    let presentingV = SplashMainImagePagerContainerV.init()
    
    var slideCount = 0
    
    var timer : Timer?
    
    var models = [SplashMainModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(presentingV)
        presentingV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func getRandomPhoto() -> Void {
        vm.loadModels(reload: true, success: { (newModels:[SplashMainModel], SplashNetworkingResult) in
            if newModels.count > 0 {
                self.timer?.invalidate()
                self.models = newModels
                self.presentingV.alpha = 0
                self.presentingV.model = self.models.first
                self.slideCount = 0
                if newModels.count > 1 {
                    KingfisherManager.shared.retrieveImage(with: URL.init(string: newModels[1].urls?.small ?? "")!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                        self.timer = Timer.init(timeInterval: 5, target: self, selector: #selector(self.tikTok), userInfo: nil, repeats: true)
                        RunLoop.current.add(self.timer! , forMode: .default)
                        UIView .animate(withDuration: 3) {
                            self.presentingV.alpha = 1
                        }
                    })
                }
            }
        }) { (String, SplashNetworkingResult) in
            
        }
    }
    
    @objc func tikTok() -> Void {
        slideCount += 1
        if slideCount >= self.models.count {
            slideCount = 0
        }
        if slideCount + 1 < self.models.count {
            KingfisherManager.shared.retrieveImage(with: URL.init(string: self.models[slideCount + 1].urls?.small ?? "")!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                
            })
        }
        
        //Animating
        let tempImgV = SplashMainImagePagerContainerV.init()
        self.addSubview(tempImgV)
        tempImgV.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.presentingV)
            make.edges.equalTo(self.presentingV)
        }
        tempImgV.setNeedsLayout()
        tempImgV.layoutIfNeeded()
        tempImgV.alpha = 0
        tempImgV.model = self.models[slideCount]
        UIView.animate(withDuration: 3, animations: {
            tempImgV.alpha = 1
            self.presentingV.alpha = 0
        }) { (finish) in

            self.presentingV.model = self.models[self.slideCount]
            self.presentingV.alpha = 1
            tempImgV.removeFromSuperview()
        }
        
    }
}
