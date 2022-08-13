//
//  RecommendViewModel.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/8/13.
//

import Foundation
import KakaJSON
import SwiftyJSON



class RecommendViewModel {
    // MARK:- 懒加载属性
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

// MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData(finishCallback: @escaping ()->()) {
        // 1.定义参数
        let parameters =  ["limit": "4", "offset": "0", "time": NSDate.getCurrentTime()]
        
        // 2.创建Group
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        
        // 1.请求第一部分推荐数据
        group.enter()
        queue.async(group: group) {
            DispatchQueue.main.async {
                NetworkTools.requestData(
                    type: .GET,
                    URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",
                    parameters: ["time": NSDate.getCurrentTime()]) { result in
                        // 1.将result转成字典类型
                        guard let resultDict = result as? [String: NSObject] else {return}
                        // 2.根据data作为key，获取数组
                        guard let dataArray = JSON(resultDict)["data"].arrayObject else {return}
                        
                        let models = modelArray(from: dataArray, AnchorModel.self)
                        self.bigDataGroup.room_list = []
                        self.bigDataGroup.room_list?.append(contentsOf: models)
                        self.bigDataGroup.tag_name = "热门"
                        group.leave()
                        
                    } callBackFailure: { result in group.leave()}
            }
        }

        // 2.请求第一部分颜值数据
        group.enter()
        queue.async(group: group) {
            DispatchQueue.main.async {
                NetworkTools.requestData(
                    type: .GET,
                    URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",
                    parameters: parameters) { result in
                        
                        // 1.将result转成字典类型
                        guard let resultDict = result as? [String: NSObject] else {return}
                        // 2.根据data作为key，获取数组
                        guard let dataArray = JSON(resultDict)["data"].arrayObject else {return}
                        let models = modelArray(from: dataArray, AnchorModel.self)
                        self.prettyGroup.room_list = []
                        self.prettyGroup.room_list?.append(contentsOf: models)
                        self.prettyGroup.tag_name = "颜值"
                        group.leave()
                    
                    } callBackFailure: { result in group.leave()}
            }
        }

        // 3.请求第一部分游戏数据
        group.enter()
        queue.async(group: group) {
            DispatchQueue.main.async {
                NetworkTools.requestData(
                    type: .GET,
                    URLString: "http://capi.douyucdn.cn/api/v1/getHotCate",
                    parameters: parameters) { result in
                        // 1.将result转成字典类型
                        guard let resultDict = result as? [String: NSObject] else {return}
                        // 2.根据data作为key，获取数组
                        guard let dataArray = JSON(resultDict)["data"].arrayObject else {return}
                        
                        let models = modelArray(from: dataArray, AnchorGroup.self)
                        self.anchorGroups.removeAll()
                        self.anchorGroups.append(contentsOf: models)
                        group.leave()
                        
                    } callBackFailure: {result in group.leave()}
            }
        }
        group.notify(queue: queue) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
}
