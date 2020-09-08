//
//  SplashListPhotosViewController.swift
//  Splash
//
//  Created by Sylar on 2020/9/8.
//  Copyright © 2020 Sylar. All rights reserved.
//

import UIKit
import SnapKit

class SplashListPhotosViewController: UIViewController {
    
    let mainCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let vm = SplashMainPageViewModel()
    
    var models = [SplashMainModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        mainCollectionView.backgroundColor = self.view.backgroundColor
        mainCollectionView.register(SplashListPhotoCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(SplashListPhotoCollectionViewCell.self))
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        self.view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.edges.equalToSuperview()
        }
        self.topRefresh()
    }
    
    func topRefresh() -> Void {
        
        vm.loadModels(reload: true, success: { (newModels:[SplashMainModel], SplashNetworkingResult) in
            self.models = newModels
            self.mainCollectionView.reloadData()
        }) { (String, SplashNetworkingResult) in
            
        }
    }
    

}



extension SplashListPhotosViewController:UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(SplashListPhotoCollectionViewCell.self), for: indexPath) as! SplashListPhotoCollectionViewCell
        cell.model = models[indexPath.row]
        return cell
    }
    
}

extension SplashListPhotosViewController:UICollectionViewDelegate{
    
}

extension SplashListPhotosViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (collectionView.frame.size.width - 20 * 2 - 30) / 2.0, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
}
