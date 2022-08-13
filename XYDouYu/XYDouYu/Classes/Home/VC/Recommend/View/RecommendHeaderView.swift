//
//  RecommendHeaderView.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/31.
//

import UIKit

class RecommendHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var anchorGroup: AnchorGroup? {
        didSet {
            self.titleLabel.text = anchorGroup?.tag_name
            self.iconImageView.image = UIImage(systemName: "iphone.homebutton")
        }
    }
    
}
