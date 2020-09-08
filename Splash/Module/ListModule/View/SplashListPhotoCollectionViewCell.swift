//
//  SplashListPhotoCollectionViewCell.swift
//  Splash
//
//  Created by Sylar on 2020/9/8.
//  Copyright © 2020 Sylar. All rights reserved.
//

import UIKit
import Kingfisher
class SplashListPhotoCollectionViewCell: UICollectionViewCell {
    
    var model:SplashMainModel?{
        didSet{
            self.photoImageView.kf.setImage(with: URL(string: self.model?.urls?.regular ?? ""))
        }
    }
    
    var photoImageView = UIImageView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
