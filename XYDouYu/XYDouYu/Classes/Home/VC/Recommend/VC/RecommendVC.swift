//
//  RecommendVC.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/30.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderH: CGFloat = 50.0
//private let kNormalCellId = String(describing: RecommendNormalCell.self)
//private let kHeaderCellId = String(describing: RecommendHeaderView.self)
//private let kPrettyCellId = String(describing: RecommendPrettyCell.self)
private let kNormalCellId = "RecommendNormalCell"
private let kHeaderCellId = "RecommendHeaderView"
private let kPrettyCellId = "RecommendPrettyCell"
private let kHeaderNibName = kHeaderCellId
private let kNormalCellNibName = kNormalCellId
private let kPrettyCellNibName = kPrettyCellId


class RecommendVC: UIViewController {

    
    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    private lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kItemW, height: kHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: kHeaderNibName, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderCellId)
        collectionView.register(UINib(nibName: "RecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "RecommendPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)
        return collectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        // 设置UI界面
        setupUI()
        // 加载数据
        loadData()
    }
}

// MARK:- 设置UI界面内容
extension RecommendVC {
    private func setupUI(){
        // 1.将UICollectionView添加到控制器View中
        view.addSubview(self.collectionView)
    }
}

extension RecommendVC {
    private func loadData() {
        recommendVM.requestData {
            if Thread.current.isMainThread {
                self.collectionView.reloadData()
            } else {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension RecommendVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.room_list?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchorModel = group.room_list?[indexPath.item]
        let cell: RecommendBaseCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for:indexPath) as! RecommendPrettyCell
        }
        else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for:indexPath) as! RecommendNormalCell
        }
        cell.anchorModel = anchorModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderCellId, for: indexPath) as! RecommendHeaderView
        
        headerView.backgroundColor = .white
        let anchorGroup = recommendVM.anchorGroups[indexPath.section]
        headerView.anchorGroup = anchorGroup
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
