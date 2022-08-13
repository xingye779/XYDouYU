//
//  File.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/8/13.
//

import Foundation
import Alamofire
import Kingfisher
enum MethodType {
    case GET
    case POST
}

struct DecodableType: Decodable {
    let url: String
}

class NetworkTools {
    class func requestData(
        type: MethodType,
        URLString: String,
        parameters: [String: String]? = nil,
        callBackSuccess: @escaping (_ result: Any)-> (),
        callBackFailure: @escaping (_ result: Any)-> ()) {
        // 1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        AF.request(URLString,
                   method: method,
                   parameters: parameters).responseJSON { response in
            
            // 3.获取结果
            guard let result = response.value else {
                callBackFailure(String(describing: response.error))
                return
            }
            // 4.将结果回调
            callBackSuccess(result)
        }
    }
    
    
    
    
    
}
