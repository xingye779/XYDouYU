//
//  UIColor_Extension.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/15.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
    }
    
}
