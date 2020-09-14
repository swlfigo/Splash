//
//  SplashMainImagePagerContainerV.swift
//  Splash
//
//  Created by Sylar on 2020/9/10.
//  Copyright © 2020 Sylar. All rights reserved.
//

import UIKit

class SplashMainImagePagerContainerV: UIView {

    var imgV = UIImageView.init()
    
    var model : SplashMainModel? {
        didSet{
            let ratio = Double(model?.width ?? 0) / Double(model?.height ?? 1)
            let imgUrl = model?.urls?.small ?? ""
            let pmDic =  imgUrl.urlParameters
            if let dic = pmDic , let w = dic["w"]?.doubleValue {
                
                let acutalH = Double(w / ratio)
                
                var calculateH = Double(self.frame.size.height)
                var calculateW = Double(self.frame.size.width)
                if w > acutalH {
                    //横长图
                    calculateW = calculateH * w / acutalH
                    if calculateW < Double(self.frame.size.width) {
                        calculateW = Double(self.frame.size.width)
                        calculateH = calculateW * acutalH / w
                    }
                    
                }else{
                    calculateH = calculateW * acutalH / w
                }
                
                self.imgV.snp.updateConstraints { (make) in
                    make.size.equalTo(CGSize.init(width: calculateW, height: calculateH))
                }
                

                let imgURL = URL.init(string: self.model?.urls?.small ?? "")
                
                self.imgV.kf.setImage(with: imgURL)
                
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imgV.contentMode = .scaleToFill
        self.addSubview(imgV)
        
        self.imgV.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize.zero)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
