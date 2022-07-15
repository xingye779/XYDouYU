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

    // MARK: -添加标题菜单
    lazy var pageTitleView : PageTitleView = {
        let y = kStatusH + CGFloat(kNavigationH)
        let frame = CGRect(x: 0, y: y, width: kScreenW, height: kMenuH)
        return PageTitleView(frame: frame, titles: titles)
    }()
    
    lazy var pageContentView: PageContentView = {
        
        let y = kStatusH + kNavigationH + kMenuH + 2.5
        let height = kScreenH - Double(kStatusH) - kNavigationH - kMenuH - kTabbarH
        let frame = CGRect(x: 0, y: y , width: kScreenW, height: height)
        var subViews: [UIViewController] = []
        titles.forEach { value in
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(
                red: CGFloat(CGFloat(arc4random_uniform(255))),
                green: CGFloat(arc4random_uniform(255)),
                blue: CGFloat(arc4random_uniform(255)))
            subViews.append(vc)
        }
        return PageContentView(frame: frame, viewControllers: subViews, parentVC: self)
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
