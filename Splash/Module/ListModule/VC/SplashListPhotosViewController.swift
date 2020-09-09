//
//  SplashListPhotosViewController.swift
//  Splash
//
//  Created by Sylar on 2020/9/8.
//  Copyright © 2020 Sylar. All rights reserved.
//

import UIKit
import SnapKit
import CHTCollectionViewWaterfallLayout
class SplashListPhotosViewController: UIViewController {
    
    var mainCollectionView : UICollectionView!
    let vm = SplashMainPageViewModel()
    
    var layouts = [SplashListPhotoLayout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 30.0
        layout.minimumInteritemSpacing = 10.0
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 30, bottom: 0, right: 30)
        mainCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
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
            
            var tempLayouts = [SplashListPhotoLayout]()
            for model in newModels{
                tempLayouts.append(SplashListPhotoLayout.init(listPhotoModel: model))
            }
            self.layouts = tempLayouts
            self.mainCollectionView.reloadData()
        }) { (String, SplashNetworkingResult) in
            
        }
    }
    

}



extension SplashListPhotosViewController:UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return layouts.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(SplashListPhotoCollectionViewCell.self), for: indexPath) as! SplashListPhotoCollectionViewCell
        cell.layout = layouts[indexPath.row]
        return cell
    }
    
}

extension SplashListPhotosViewController:UICollectionViewDelegate{
    
}

extension SplashListPhotosViewController : CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let pModel = layouts[indexPath.row].model
        let ratio = Double(pModel?.width ?? 0) / Double(pModel?.height ?? 1)
        
        let imgUrl = pModel?.urls?.regular ?? ""
        let pmDic =  imgUrl.urlParameters
        if let dic = pmDic , let w = dic["w"]?.doubleValue {
            
            let acutalH = Double(w / ratio)
            
            let collectionVWidth = Double((collectionView.frame.size.width - 30 * 3) / 2.0)
            
            let collectionVHeight = collectionVWidth / (w / acutalH)
            
            return CGSize.init(width: collectionVWidth, height: ceil(Double(collectionVHeight)))
        }
        return CGSize.zero
        
        
        
    }
    
    
}

extension String {
    /// 从String中截取出参数
    var urlParameters: [String: AnyObject]? {
        // 截取是否有参数
        guard let urlComponents = NSURLComponents(string: self), let queryItems = urlComponents.queryItems else {
            return nil
        }
        // 参数字典
        var parameters = [String: AnyObject]()
        
        // 遍历参数
        queryItems.forEach({ (item) in
            
            // 判断参数是否是数组
            if let existValue = parameters[item.name], let value = item.value {
                // 已存在的值，生成数组
                if var existValue = existValue as? [AnyObject] {
                    
                    existValue.append(value as AnyObject)
                } else {
                    parameters[item.name] = [existValue, value] as AnyObject
                }
                
            } else {
                
                parameters[item.name] = item.value as AnyObject
            }
        })
        
        return parameters
    }
}
