//
//  AnchorGroup.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/8/13.
//

import Foundation
import KakaJSON

struct AnchorGroup: Convertible {
    // 该组中对应的房间信息
    var room_list: [AnchorModel]?
    // 组显示的标题
    var tag_name: String = ""
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        return property.name.kj.underlineCased()
    }
}
