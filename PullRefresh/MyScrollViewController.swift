//
//  SecondViewController.swift
//  RefreshExample
//
//  Created by SunSet on 14-6-23.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import UIKit

class MyScrollViewController: UIViewController {
    var scrollView:UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        var rect:CGRect = self.view.frame
        scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scrollView!)
        scrollView!.contentSize = self.view.frame.size
        scrollView!.backgroundColor = UIColor.clearColor()
        self.setupRefresh()
    }
    
    func setupRefresh(){
        self.scrollView!.addHeaderWithCallback({
            let delayInSeconds:Int64 = 1000000000 * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.scrollView!.contentSize = self.view.frame.size
                self.scrollView!.headerEndRefreshing()
                })
            })
        
        self.scrollView!.addFooterWithCallback({
            let delayInSeconds:Int64 =  1000000000 * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                   var size:CGSize = self.scrollView!.frame.size
                    size.height = size.height + 300
                    self.scrollView!.contentSize = size
                    self.scrollView!.footerEndRefreshing()
                
                
                })
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

