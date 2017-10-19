
//
//  File.swift
//  RefreshExample
//
//  Created by SunSet on 14-6-23.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//
import UIKit
class RefreshFooterView: RefreshBaseView {
    class func footer()->RefreshFooterView{
        let footer:RefreshFooterView  = RefreshFooterView(frame:
            CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(RefreshViewHeight)))
        return footer
    }
    
    var lastRefreshCount:Int = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.statusLabel.frame = self.bounds;
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if (self.superview != nil){
            self.superview!.removeObserver(self, forKeyPath: RefreshContentSize,context:nil)
        }
        if let newSuperview = newSuperview  {
            newSuperview.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
            // 重新调整frame
           adjustFrameWithContentSize()
        }
    }
    
    //重写调整frame
    func adjustFrameWithContentSize(){
        let contentHeight:CGFloat = self.scrollView.contentSize.height//
        let scrollHeight:CGFloat = self.scrollView.frame.size.height  - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom
        var rect:CGRect = self.frame;
        rect.origin.y =  contentHeight > scrollHeight ? contentHeight : scrollHeight
        self.frame = rect;
    }
 
    //监听UIScrollView的属性
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (!self.isUserInteractionEnabled || self.isHidden){
            return
        }
        if RefreshContentSize == keyPath{
            adjustFrameWithContentSize()
        }else if RefreshContentOffset == keyPath{
            if self.state == RefreshState.refreshing{
                return
            }
            adjustStateWithContentOffset()
        }
    }
    
    func adjustStateWithContentOffset()
    {
        let currentOffsetY:CGFloat  = self.scrollView.contentOffset.y
        let happenOffsetY:CGFloat = self.happenOffsetY()
        if currentOffsetY <= happenOffsetY {
            return
        }
        if self.scrollView.isDragging {
            let normal2pullingOffsetY =  happenOffsetY + self.frame.size.height
            if self.state == RefreshState.normal && currentOffsetY > normal2pullingOffsetY {
                self.state = RefreshState.pulling;
            } else if (self.state == RefreshState.pulling && currentOffsetY <= normal2pullingOffsetY) {
                self.state = RefreshState.normal;
            }
        } else if (self.state == RefreshState.pulling) {
            self.state = RefreshState.refreshing
        }
    }

 
    override var state:RefreshState {
 
    willSet {
        if  state == newValue{
            return;
        }
        oldState = state
        self.setState(newValue: newValue)
//        state = newValue
    }
        
    didSet{
        switch state{
        case .normal:
            self.statusLabel.text = RefreshFooterPullToRefresh;
            if (RefreshState.refreshing == oldState) {
                self.arrowImage.transform.rotated(by: .pi)
                UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                    self.scrollView.contentInset.bottom = self.scrollViewOriginalInset.bottom
                })
            } else {
                UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                    self.arrowImage.transform.rotated(by: .pi)
                })
            }
            let deltaH:CGFloat = self.heightForContentBreakView()
            let currentCount:Int = self.totalDataCountInScrollView()
            if (RefreshState.refreshing == oldState && deltaH > 0  && currentCount != self.lastRefreshCount) {
                var offset:CGPoint = self.scrollView.contentOffset;
                offset.y = self.scrollView.contentOffset.y
                self.scrollView.contentOffset = offset;
            }
            
            break
        case .pulling:
            self.statusLabel.text = RefreshFooterReleaseToRefresh
            UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
               self.arrowImage.transform = .identity
                })
            break
        case .refreshing:
            self.statusLabel.text = RefreshFooterReleaseToRefresh;
            self.lastRefreshCount = self.totalDataCountInScrollView();
            UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                var bottom:CGFloat = self.frame.size.height + self.scrollViewOriginalInset.bottom
                let deltaH:CGFloat = self.heightForContentBreakView()
                if deltaH < 0 {
                    bottom = bottom - deltaH
                }
                var inset:UIEdgeInsets = self.scrollView.contentInset;
                inset.bottom = bottom;
                self.scrollView.contentInset = inset;
             
                })
            
            break
        default:
            break

        }
    }
    }
    
    
    func  totalDataCountInScrollView()->Int
    {
        var totalCount:Int = 0
        if let tableView = self.scrollView as? UITableView {
            for x in 0..<tableView.numberOfSections{
                totalCount = totalCount + tableView.numberOfRows(inSection: x)
            }
        } else if let collectionView = self.scrollView as? UICollectionView{

            for x in 0..<collectionView.numberOfSections{
                totalCount = totalCount + collectionView.numberOfItems(inSection: x)
            }
        }
        return totalCount
    }
    
    func heightForContentBreakView()->CGFloat
    {
        let h:CGFloat  = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top
        return self.scrollView.contentSize.height - h
    }
    
    
    func happenOffsetY()->CGFloat
    {
        let deltaH:CGFloat = self.heightForContentBreakView()
        if deltaH > 0 {
            return   deltaH - self.scrollViewOriginalInset.top;
        } else {
            return  -self.scrollViewOriginalInset.top;
        }
    }
    
     func addState(state:RefreshState){
        self.state = state
    }
    
}
