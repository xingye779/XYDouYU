//
//  AnchorModel.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/8/13.
//

import Foundation
import KakaJSON

struct AnchorModel: Convertible{
    var room_id: String = ""
    var show_time: Int = 0
    var vertical_src: String = ""
    var hot: Int = 100
    var avatar_small: String = ""
    var specific_status: Int = 0
    var room_src: String = ""
    var room_name: String = ""
    var game_name: String = ""
    var isVertical: Int = 0
    var owner_uid: Int = 0
    var ranktype: String = ""
    var nickname: String = ""
    var online: String = ""
    var show_status: Int = 0
    var specific_catalog: String = ""
    var avatar_mid: String = ""
    var jumpUrl: Int = 0
    var rmf1: Int = 0
    var rmf2: Int = 0
    var rmf3: Int = 0
    var rmf4: Int = 0
    var rmf5: Int = 0
    // 颜值用到的属性
    var cate_id: Int = 0
    var subject: String = ""
    var vod_quality: Bool = false
    var child_id: Int = 0
    var hn: Int = 0
    var anchor_city: String = ""
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        return property.name.kj.underlineCased()
    }
}
