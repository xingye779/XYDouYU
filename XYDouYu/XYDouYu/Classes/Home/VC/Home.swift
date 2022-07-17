//
//  Home.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/12.
//

import UIKit
import Foundation

class Home: UIViewController {
    
    let titles = ["热门", "颜值", "舞蹈", "交友", "二次元"]

    // MARK:- 懒加载属性
    lazy var pageTitleView : PageTitleView = {[weak self] in
        let y = kStatusH + CGFloat(kNavigationH)
        let frame = CGRect(x: 0, y: y, width: kScreenW, height: kMenuH)
        let titleView = PageTitleView(frame: frame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    lazy var pageContentView: PageContentView = {[weak self] in
        // 1.确定内容的frame
        let y = kStatusH + kNavigationH + kMenuH
        let height = kScreenH - Double(kStatusH) - kNavigationH - kMenuH - kTabbarH
        let frame = CGRect(x: 0, y: y , width: kScreenW, height: height)
        // 2.确定所有的子控制器
        var subViews: [UIViewController] = []
        titles.forEach { value in
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(
                red: CGFloat(CGFloat(arc4random_uniform(255))),
                green: CGFloat(arc4random_uniform(255)),
                blue: CGFloat(arc4random_uniform(255)))
            subViews.append(vc)
        }
        let pageContentView = PageContentView(frame: frame, viewControllers: subViews, parentVC: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setupUI()
    }
}


// MARK:- 设置UI界面
extension Home {
    private func setupUI() {
        // 0.不需要调整UIScrollView的内边距
        if #available(iOS 11, *) {}
        else {
            automaticallyAdjustsScrollViewInsets = false
        }
        // 1.设置导航栏
        setupNavigationBar()
        // 2.添加titleView
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationBar() {
        
        // 创建左边按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "scovery", target: self, selctor: #selector(scovery))
        // 创建右边按钮
        let size = CGSize(width: 35, height: 35)
        let historyBarButtonItem = UIBarButtonItem(image: "attention", target: self, selctor: #selector(attention), size: size)
        let searchBarButtonItem = UIBarButtonItem(image: "checkin", target: self, selctor: #selector(checkin), size: size)
        let codeBarButtonItem = UIBarButtonItem(image: "onekeyOpenLive", target: self, selctor: #selector(onekeyOpenLive), size: size)
        navigationItem.rightBarButtonItems = [historyBarButtonItem, searchBarButtonItem, codeBarButtonItem]
    }

    @objc func scovery(sender: Any?) {
        print("scovery--点击")
    }
    
    @objc func attention(sender: Any?) {
        print("attention--点击")
    }
    
    @objc func checkin(sender: Any?) {
        print("checkin--点击")
    }

    @objc func onekeyOpenLive(sender: Any?) {
        print("onekeyOpenLive--点击")
    }

}

// MARK:- 遵守PageTitleViewDelegate协议
extension Home: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex: Int) {
        print(selectIndex)
        pageContentView.setCurrentIndex(currentIndex: selectIndex)
    }
}
 
extension Home: PageContentViewDelegate {
    func pageContentViewWithScrollValue(
        contentView: PageContentView,
        progress: Double,
        sourceIndex: Int,
        targetIndex: Int) {
            pageTitleView.setTitleViewTitleAndScrollLine(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
