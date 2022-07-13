//
//  Main.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/12.
//

import UIKit

class Main: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(name: "Home")
        addChildViewController(name: "Live")
        addChildViewController(name: "Follow")
        addChildViewController(name: "Mine")
    }
    
    private func addChildViewController(name: String) {
        let vc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        addChild(vc)
    }
    
}
