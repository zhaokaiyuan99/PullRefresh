//
//  FirstViewController.swift
//  RefreshExample
//
//  Created by SunSet on 14-6-23.
//  Copyright (c) 2014 zhaokaiyuan. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    var fakeData:NSMutableArray?

 
    
    func setupRefresh(){
          self.tableView.addHeaderWithCallback({
            self.fakeData!.removeAllObjects()
            for (var i:Int = 0; i<15; i++) {
                var text:String = "内容"+String( arc4random_uniform(10000))
                self.fakeData!.addObject(text)
            }
            let delayInSeconds:Int64 = NSEC_PER_SEC.asSigned() * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.tableView.headerEndRefreshing()
                })
            
            })
        
        
        
        self.tableView.addFooterWithCallback({
            for (var i:Int = 0; i<10; i++) {
                var text:String = "内容"+String( arc4random_uniform(10000))

                self.fakeData!.addObject(text)
            } 
            let delayInSeconds:Int64 = NSEC_PER_SEC.asSigned() * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
               self.tableView.reloadData()
                self.tableView.footerEndRefreshing()
                
              //self.tableView.setFooterHidden(true)
                })
         })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fakeData = NSMutableArray()
        for (var i:Int = 0; i<15; i++) {
            var text:String = "内容"+String( arc4random_uniform(10000))
            self.fakeData!.addObject(text)
        }
        
       self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "TableViewCellIdentifier")
        self.setupRefresh()
        
       // tas.assaf()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.fakeData!.count
    }
    
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
     
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
    
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil { // no value
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell") as UITableViewCell
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
           var statusLabel = UILabel()
            statusLabel.frame = CGRectMake(0, 0, 320, 36)
            statusLabel.font = UIFont.boldSystemFontOfSize(13)
            statusLabel.textColor = UIColor.blackColor()
            statusLabel.backgroundColor = UIColor.clearColor()
            statusLabel.textAlignment = NSTextAlignment.Center
            cell!.contentView.addSubview(statusLabel)
            statusLabel.tag = 1000001
        }
        var statusLabel:UILabel = cell!.contentView.viewWithTag(1000001) as  UILabel
        statusLabel.text = fakeData!.objectAtIndex(indexPath.row) as String
        
         return cell!
    }
    
    
    
}

