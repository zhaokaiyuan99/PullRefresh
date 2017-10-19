//
//  UIScrollView+Refresh.swift
//  RefreshExample
//
//  Created by SunSet on 14-6-24.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import UIKit



extension UIScrollView {
    func addHeaderWithCallback( callback:(() -> Void)!){
        let header:RefreshHeaderView = RefreshHeaderView.footer()
        self.addSubview(header)
        header.beginRefreshingCallback = callback
        header.addState(state: RefreshState.normal)
    }
    
    func removeHeader()
    {
        
        for object : AnyObject in self.subviews{
            if let view = object as? RefreshHeaderView{
                view.removeFromSuperview()
            }
        }
    }
    
    
    func headerBeginRefreshing()
    {
        
        for object : AnyObject in self.subviews{
            if let view = object as? RefreshHeaderView{
                view.beginRefreshing()
            }
        }
        
    }
    
    
    func headerEndRefreshing()
    {
        for object : AnyObject in self.subviews{
            if let view = object as? RefreshHeaderView{
                view.endRefreshing()
            }
        }
        
    }
    
    func setHeaderHidden(hidden:Bool)
    {
        for object : AnyObject in self.subviews{
            if let view  = object as? RefreshHeaderView{
                view.isHidden = hidden
            }
        }
    }
    
    func isHeaderHidden()
    {
        for object : AnyObject in self.subviews{
            if let view = object as? UIView{
                view.isHidden = isHidden
            }
        }
    }
    
   func addFooterWithCallback( callback:(() -> Void)!){
        let footer:RefreshFooterView = RefreshFooterView.footer()
        self.addSubview(footer)
        footer.beginRefreshingCallback = callback
        footer.addState(state: RefreshState.normal)
    }
    
     func removeFooter(){
    
        for object : AnyObject in self.subviews{
            if let view = object as? RefreshFooterView{
                view.removeFromSuperview()
            }
        }
    }
    
    func footerBeginRefreshing(){
        for object : AnyObject in self.subviews{
            if let view = object as? RefreshFooterView{
                view.beginRefreshing()
            }
        }
    }
    
    func footerEndRefreshing(){
        for object : AnyObject in self.subviews{
            if let view = object as? RefreshFooterView{
                view.endRefreshing()
            }
        }
    }
  
    func setFooterHidden(hidden:Bool){
        for object : AnyObject in self.subviews{
            if let view:UIView  = object as? RefreshFooterView{
                view.isHidden = hidden
            }
        }
    }
    
    func isFooterHidden(){
        for object : AnyObject in self.subviews{
            if let view:UIView  = object as? RefreshFooterView{
                view.isHidden = isHidden
            }
        }
    }
}
