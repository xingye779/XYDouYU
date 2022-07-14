//
//  Macro.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/14.
//

import UIKit

let kStatusH: CGFloat = {
    if #available(iOS 13.0, *) {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let frame = scene?.statusBarManager?.statusBarFrame
        return frame?.height ?? 20
    }
    else {
        return UIApplication.shared.statusBarFrame.size.height
    }
}()
let kNavigationH = 44
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
