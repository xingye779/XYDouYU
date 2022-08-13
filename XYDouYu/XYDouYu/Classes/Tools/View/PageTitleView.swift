//
//  PageTitleView.swift
//  XYDouYu
//
//  Created by 黄兴 on 2022/7/14.
//

import UIKit

let scrollLineH = 2
let bottomLineH = 0.5
let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85.0, 85.0, 85.0)
let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255.0, 128.0, 0.0)

protocol PageTitleViewDelegate: AnyObject {
    func pageTitleView(titleView: PageTitleView, selectIndex: Int)
}

class PageTitleView: UIView {

    // MARK:- 定义属性
    private var titleLabels: [String]
    private var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    // MARK:- 懒加载属性
    private lazy var labels: [UILabel] = [UILabel]()
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        // 0.不需要调整UIScrollView的内边距
        //(当scrollView父视图也有导航栏时，scrollView会添加内边距)
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = .orange
        return scrollLine
    }()
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        titleLabels = titles;
        super.init(frame: frame)
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置界面
extension PageTitleView {
    
    private func setupUI() {
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加title对应的Label
        setupTitleLabels()
        
        // 3.设置底线和滚动的滑块
        setupScrollLineAndBottomLine()
    }
    
    private func setupTitleLabels() {
        
        // 0.确定Label的一些frame的值
        let labelW = kScreenW / CGFloat(titleLabels.count)
        let labelH = self.bounds.size.height - CGFloat(scrollLineH) - CGFloat(bottomLineH)
        for (index, title) in titleLabels.enumerated() {
            // 1.创建UILabel
            let label = UILabel()
            
            // 2.设置Label的属性
            label.text = title
            label.tag = index
            label.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2)
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            
            // 3.设置Label的frame
            let labelX = labelW * CGFloat(index)
            let recet = CGRect(x: labelX, y: 0, width: labelW, height: labelH)
            label.frame = recet
            
            // 4.将Label添加到scrollView中
            scrollView.addSubview(label)
            labels.append(label)
            
            // 5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupScrollLineAndBottomLine() {
        // 1.添加底线
        let bottomLine = UIView()
        let size = bounds.size
        bottomLine.backgroundColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2)
        bottomLine.frame = CGRect(x: 0, y: bounds.height + CGFloat(scrollLineH), width:size.width , height: bottomLineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1.获得第一个Label
        guard let firstLabel = labels.first else {return}
        firstLabel.textColor = UIColor(red: kSelectColor.0, green: kSelectColor.1, blue: kSelectColor.2)
        let frame = firstLabel.frame
        let scrollLineY = bounds.size.height
        let scrollLineW = frame.size.width
        // 2.2.设置scrollView的属性
        addSubview(scrollLine)
        scrollLine.frame = CGRect(
            x: frame.origin.x,
            y: scrollLineY - CGFloat(scrollLineH),
            width: scrollLineW,
            height: CGFloat(scrollLineH))
    }
}

// MARK:- 监听Labe的点击
extension PageTitleView {
    
    @objc func titleLabelClick(tapGes: UITapGestureRecognizer) {
        print("我被点击了")
        // 1.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else {return}
        guard currentLabel.tag != currentIndex else {return}
        // 2.获取之前的Label
        let oldLabel = labels[currentIndex]
        
        // 3.切换文字颜色
        oldLabel.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2)
        currentLabel.textColor = UIColor(red: kSelectColor.0, green: kSelectColor.1, blue: kSelectColor.2)

        // 4.保存最新Label的下标
        currentIndex = currentLabel.tag
        
        // 5.滚动条位置发生改变
        let scrollX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.frame.origin.x = scrollX
        }
        
        // 6.通知代理
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }
}

extension PageTitleView {
    func setTitleViewTitleAndScrollLine(
        progress: Double,
        sourceIndex: Int,
        targetIndex: Int) {
        print("progress---:\(progress)")
        print("sourceIndex---:\(sourceIndex)")
        print("targetIndex---:\(targetIndex)")
            
        // 1.获取之前的Label
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        // 2.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        self.scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
    
        // 3.颜色的渐变
        // 3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
            
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(
            red: kSelectColor.0 - colorDelta.0 * progress,
            green: kSelectColor.1 - colorDelta.1 * progress,
            blue: kSelectColor.2 - colorDelta.2 * progress)
            
        // 3.3.变化targetLabel
        targetLabel.textColor = UIColor(
            red: kNormalColor.0 + colorDelta.0 * progress,
            green: kNormalColor.1 + colorDelta.1 * progress,
            blue: kNormalColor.2 + colorDelta.2 * progress)
            
        // 4.记录更新的index
        currentIndex = targetIndex
    }
}
