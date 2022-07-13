//
//  UIBarButtonItem_Extension.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/12.
//

import UIKit

extension UIBarButtonItem {
    // 扩展类方法
    class func createItem(
        image: String,
        target: Any? ,
        selctor: Selector,
        highImage: String = "",
        size: CGSize = CGSize.zero) -> UIBarButtonItem {
            
        let btn = UIButton()
        if (size != CGSize.zero) {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        else {
            btn.sizeToFit()
        }
        if (highImage != "") {
            btn.setImage(UIImage(named: highImage), for: .highlighted)
        }
        if (target != nil) {
            btn.addTarget(target, action: selctor, for: .touchUpInside)
        }
        btn.setImage(UIImage(named: image), for: .normal)
        return UIBarButtonItem(customView: btn)
    }
    
    // 提供便捷初始化器
    convenience init(
        image: String,
        target: Any? ,
        selctor: Selector,
        highImage: String = "",
        size: CGSize = CGSize.zero) {
            
        let btn = UIButton()
        if (size != CGSize.zero) {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        else {
            btn.sizeToFit()
        }
        if (highImage != "") {
            btn.setImage(UIImage(named: highImage), for: .highlighted)
        }
        if (target != nil) {
            btn.addTarget(target, action: selctor, for: .touchUpInside)
        }
        btn.setImage(UIImage(named: image), for: .normal)
        self.init(customView: btn)
    }
}
