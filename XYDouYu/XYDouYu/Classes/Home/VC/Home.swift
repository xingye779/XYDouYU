//
//  Home.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/12.
//

import UIKit

class Home: UIViewController {
    // MARK: -添加标题菜单
    lazy var pageTitleView : PageTitleView = {
        let y = kStatusH + CGFloat(kNavigationH)
        let frame = CGRect(x: 0, y: y, width: kScreenW, height: 44.0)
        let titles = ["热门", "颜值", "舞蹈", "交友", "二次元"]
        return PageTitleView(frame: frame, titles: titles)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


extension Home {
    private func setupUI() {
        setupNavigationBar()
        view.addSubview(pageTitleView)
        
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
