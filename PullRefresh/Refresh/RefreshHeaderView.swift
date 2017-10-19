//
//  RefreshHeaderView.swift
//  RefreshExample
//
//  Created by SunSet on 14-6-24.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import UIKit
class RefreshHeaderView: RefreshBaseView {
    
    class func footer()->RefreshHeaderView{
        let footer:RefreshHeaderView  = RefreshHeaderView(frame:
            CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(RefreshViewHeight)))
        return footer
    }
    
    // 最后的更新时间
    var lastUpdateTime:Date = Date(){
        willSet{
        
        }
        didSet{
            UserDefaults.standard.setValue(lastUpdateTime, forKey: RefreshHeaderTimeKey)
            UserDefaults.standard.synchronize()
            self.updateTimeLabel()
        }
    }
    
    // 最后的更新时间lable
    var lastUpdateTimeLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lastUpdateTimeLabel = UILabel()
        lastUpdateTimeLabel.autoresizingMask = UIViewAutoresizing.flexibleWidth
        lastUpdateTimeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        lastUpdateTimeLabel.textColor = RefreshLabelTextColor
        lastUpdateTimeLabel.backgroundColor = UIColor.clear
        lastUpdateTimeLabel.textAlignment = .center
        self.addSubview(lastUpdateTimeLabel);
        
        if let date = UserDefaults.standard.object(forKey: RefreshHeaderTimeKey) as? Date {
            self.lastUpdateTime = date
        } else {
            self.lastUpdateTime = Date()
        }
        self.updateTimeLabel()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let statusX:CGFloat = 0
        let statusY:CGFloat = 0
        let statusHeight:CGFloat = self.frame.size.height * 0.5
        let statusWidth:CGFloat = self.frame.size.width
        //状态标签
        self.statusLabel.frame = CGRect(x: statusX, y: statusY, width: statusWidth, height: statusHeight)
        //时间标签
        let lastUpdateY:CGFloat = statusHeight
        let lastUpdateX:CGFloat = 0
        let lastUpdateHeight:CGFloat = statusHeight
        let lastUpdateWidth:CGFloat = statusWidth
        self.lastUpdateTimeLabel.frame = CGRect(x: lastUpdateX, y: lastUpdateY, width: lastUpdateWidth, height: lastUpdateHeight)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
         // 设置自己的位置和尺寸
        var rect:CGRect = self.frame
        rect.origin.y = -self.frame.size.height
        self.frame = rect
    }
    
    func updateTimeLabel(){
        //更新时间字符串
//        let calendar = Calendar.current
//        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute]
        
//        let cmp1 = calendar.dateComponents(components, from: lastUpdateTime)
//        let cmp2 = calendar.dateComponents(components, from: Date())
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let time:String = formatter.string(from: lastUpdateTime)
        self.lastUpdateTimeLabel.text = "最后刷新时间:"+time
    }
    
    //监听UIScrollView的contentOffset属性
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (!self.isUserInteractionEnabled || self.isHidden){
            return
        }
        if (self.state == RefreshState.refreshing) {
            return
        }
        if RefreshContentOffset == keyPath{
            self.adjustStateWithContentOffset()
        }
    }
    
    //调整状态
    func adjustStateWithContentOffset()
    {
        let currentOffsetY:CGFloat = self.scrollView.contentOffset.y
        let happenOffsetY:CGFloat = -self.scrollViewOriginalInset.top
        if (currentOffsetY >= happenOffsetY) {
            return
        }
        if self.scrollView.isDragging{
            let normal2pullingOffsetY:CGFloat = happenOffsetY - self.frame.size.height
            if  self.state == RefreshState.normal && currentOffsetY < normal2pullingOffsetY{
                self.state = RefreshState.pulling
            }else if self.state == RefreshState.pulling && currentOffsetY >= normal2pullingOffsetY{
                self.state = RefreshState.normal
            }
            
        } else if self.state == RefreshState.pulling {
            self.state = RefreshState.refreshing
        }
    }
    
    //设置状态
    override  var state:RefreshState {
    willSet {
        if state == newValue{
            return
        }
        oldState = state
        self.setState(newValue: newValue)
    }
    didSet{
        switch state{
        case .normal:
            self.statusLabel.text = RefreshHeaderPullToRefresh
            if RefreshState.refreshing == oldState {
                self.arrowImage.transform = .identity
                self.lastUpdateTime = Date()
                UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                    var contentInset:UIEdgeInsets = self.scrollView.contentInset
                    contentInset.top = self.scrollViewOriginalInset.top
                    self.scrollView.contentInset = contentInset
                    })
                
            }else {
                UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                     self.arrowImage.transform = .identity
                    })
            }
            break
        case .pulling:
            self.statusLabel.text = RefreshHeaderReleaseToRefresh
            UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                 self.arrowImage.transform.rotated(by: .pi)
                })
            break
        case .refreshing:
            self.statusLabel.text =  RefreshHeaderRefreshing;
            
            UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                let top:CGFloat = self.scrollViewOriginalInset.top + self.frame.size.height
                var inset:UIEdgeInsets = self.scrollView.contentInset
                inset.top = top
                self.scrollView.contentInset = inset
                var offset:CGPoint = self.scrollView.contentOffset
                offset.y = -top
                self.scrollView.contentOffset = offset
                })
            break
        default:
            break
            
        }
    }
    }
    
    func addState(state:RefreshState){
        self.state = state
    }
}
    
