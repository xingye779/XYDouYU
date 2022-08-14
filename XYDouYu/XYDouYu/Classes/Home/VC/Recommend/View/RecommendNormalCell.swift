//
//  RecommendNormalCell.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/31.
//

import UIKit
class RecommendNormalCell: RecommendBaseCell {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomTitleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    
   override  var anchorModel: AnchorModel? {
        didSet {
            super.anchorModel = anchorModel
            
            guard let anchor = anchorModel else {return}
            nickNameLabel.text = anchor.nickname
            roomTitleLabel.text = anchor.room_name
            desLabel.text = anchor.game_name
        }
    }
}
