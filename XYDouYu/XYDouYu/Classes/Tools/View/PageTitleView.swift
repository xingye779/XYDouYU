//
//  PageTitleView.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/14.
//

import UIKit

let scrollLineH = 2
let bottomLineH = 0.5

class PageTitleView: UIView {

    var titleLabels: [String]
    var labels: [UILabel] = []
    init(frame: CGRect, titles: [String]) {
        titleLabels = titles;
        super.init(frame: frame)
        // MARK: -初始化title
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageTitleView {
    
    private func setupUI() {
        
        setupTitleLabels()
        setupScrollLineAndBottomLine()
    }
    
    private func setupTitleLabels() {
        
        let labelW = kScreenW / CGFloat(titleLabels.count)
        let labelH = self.bounds.size.height - CGFloat(scrollLineH) - CGFloat(bottomLineH)
        for (index, title) in titleLabels.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .center
            let labelX = labelW * CGFloat(index)
            let recet = CGRect(x: labelX, y: 0, width: labelW, height: labelH)
            label.frame = recet
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    private func setupScrollLineAndBottomLine() {
        
        let scrollLine = UIView()
        scrollLine.backgroundColor = .orange
        let label: UILabel? = labels.first
        guard label != nil  else {return}
        let frame = label?.frame
        let scrollLineY = self.bounds.size.height
        let scrollLineW = frame?.size.width ?? 0.0
        scrollLine.frame = CGRect(x: 0, y: scrollLineY, width: scrollLineW, height: CGFloat(scrollLineH))
        self.addSubview(scrollLine)
        
        let bottomLine = UIView()
        let size = self.bounds.size
        bottomLine.backgroundColor = .darkGray
        bottomLine.frame = CGRect(x: 0, y:self.bounds.height + CGFloat(scrollLineH), width:size.width , height: bottomLineH)
        self.addSubview(bottomLine)
    }
}
