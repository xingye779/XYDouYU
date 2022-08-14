//
//  RecommendPrettyCell.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/31.
//

import UIKit

class RecommendPrettyCell: RecommendBaseCell {

    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override var anchorModel: AnchorModel? {
        didSet {
            super.anchorModel = anchorModel
            
            guard let anchor = anchorModel else {return}
            titleLabel.text = anchor.room_name
            onlineLabel.text = anchor.online
            cityLabel.text = anchor.anchor_city
        }
    }
}
