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
    
    var layout:SplashListPhotoLayout?{
        didSet{
            let model = layout?.model
            self.photoImageView.kf.setImage(with: URL(string: model?.urls?.small ?? ""))
        }
    }
    
    var photoImageView = UIImageView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        photoImageView.layer.cornerRadius = 12
        photoImageView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
