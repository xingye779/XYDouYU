//
//  RecommendBaseCell.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/8/14.
//

import UIKit

class RecommendBaseCell: UICollectionViewCell {
 
    @IBOutlet weak var iconImageView: UIImageView!
    var anchorModel: AnchorModel? {
        didSet {
            guard let anchor = anchorModel else {return}
            guard let url = URL(string: anchor.vertical_src) else {return}
            self.iconImageView?.kf.setImage(with: url)
        }
    }
}
