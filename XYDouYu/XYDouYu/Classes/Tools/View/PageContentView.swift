//
//  PageContentView.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/15.
//

import UIKit

protocol PageContentViewDelegate: AnyObject {
    func pageContentViewWithScrollValue(
        contentView: PageContentView,
        progress: Double,
        sourceIndex: Int,
        targetIndex: Int
    )
}

class PageContentView: UIView {
    
    // MARK:- 定义属性
    private var isForbidScrollDelegate: Bool = false
    weak var delegate: PageContentViewDelegate?
    private var startContentOffsetX: Double = 0.0
    private var viewControllers: [UIViewController]
    private weak var parentVC: UIViewController?
    private var cellId: String = ""

    // MARK:- 懒加载属性
    private lazy var collectView: UICollectionView = {[weak self] in
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let frame = CGRect(origin: CGPoint.zero, size: (self?.bounds.size)!)
        collectView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.bounces = false
        collectView.showsHorizontalScrollIndicator = false
        collectView.isPagingEnabled = true
        cellId = String(describing: UICollectionViewCell.self)
        collectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectView
    }()
    // MARK:- 自定义构造函数
    init(frame: CGRect, viewControllers: [UIViewController], parentVC: UIViewController?) {
        self.viewControllers = viewControllers
        self.parentVC = parentVC
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension PageContentView {
    
    private func setupUI() {
        // 1.将所有子控制器添加到父控制器中
        for childVC in viewControllers {
            parentVC?.addChild(childVC)
        }
        // 2.添加UICollectionView，用于在cell中存放控制器的View
        self.addSubview(collectView)
    }
}

extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        // 2.给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let vc = viewControllers[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
}


extension PageContentView: UICollectionViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        startContentOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {return}
        // 1.定义获取需要的数据
        var progress: Double = 0.0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let contentOffsetX = scrollView.contentOffset.x
        let collectionViewW = collectView.bounds.width
        let offsetX = contentOffsetX / collectionViewW
        // 左滑
        if contentOffsetX > startContentOffsetX {
            // 1.计算progress
            progress = offsetX - floor(offsetX)
            // 2.计算sourceIndex
            sourceIndex = Int(offsetX)
            // 3.计算target
            targetIndex = sourceIndex + 1
            // 4.滚动到最右边
            if targetIndex >= viewControllers.count {
                targetIndex = viewControllers.count - 1
            }
            // 5.如果完全划过
            if contentOffsetX - startContentOffsetX == collectionViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }
        // 右滑
        else {
            // 1.计算progress
            progress = 1 - (offsetX - floor(offsetX))
            // 2.计算target
            targetIndex = Int(offsetX)
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            // 4.滚动到最右边
            if targetIndex >= viewControllers.count {
                targetIndex = viewControllers.count - 1
            }
        }
        // 将progress/sourceIndex/targetIndex传递给pageTitleView
        delegate?.pageContentViewWithScrollValue(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectView.frame.width
        collectView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
