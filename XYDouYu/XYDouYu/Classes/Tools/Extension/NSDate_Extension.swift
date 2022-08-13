//
//  NSDate_Extension.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/8/13.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
