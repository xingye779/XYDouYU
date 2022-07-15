//
//  PageContentView.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/15.
//

import UIKit

class PageContentView: UIView {
    
    var viewControllers: [UIViewController]
    var parentVC: UIViewController
    var collectView: UICollectionView!
    var cellId: String = ""
    init(frame: CGRect, viewControllers: [UIViewController], parentVC: UIViewController) {
        self.viewControllers = viewControllers
        self.parentVC = parentVC
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    
    private func setupUI() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let size = self.bounds.size
        layout.itemSize = CGSize(width: size.width, height: size.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        collectView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.bounces = false
        collectView.showsHorizontalScrollIndicator = false
        collectView.isPagingEnabled = true
        cellId = String(describing: UICollectionViewCell.self)
        collectView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.addSubview(collectView)
    }
}

extension PageContentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let vc = viewControllers[indexPath.row]
        cell.contentView.addSubview(vc.view)
        parentVC.addChild(vc)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
}
