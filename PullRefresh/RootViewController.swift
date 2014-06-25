//
//  RootView.swift
//  RefreshExample
//
//  Created by SunSet on 14-6-24.
//  Copyright (c) 2014年 zhaokaiyuan. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "TableViewCellIdentifier")
       
        
        // tas.assaf()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
     
        if indexPath.row == 0 {
            self.navigationController.pushViewController(MyTableViewController(), animated: true)
        }else if indexPath.row == 1{
            self.navigationController.pushViewController(MyScrollViewController(), animated: true)
        }
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil { // no value
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell") as UITableViewCell
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            var label = UILabel()
            label.frame = CGRectMake(0, 0, 320, 36)
            label.font = UIFont.boldSystemFontOfSize(13)
            label.textColor = UIColor.blackColor()
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = NSTextAlignment.Center
            cell!.contentView.addSubview(label)
            label.tag = 1000001
        }
        var label:UILabel = cell!.contentView.viewWithTag(1000001) as  UILabel
        
        if indexPath.row == 0 {
         label.text = "tableView"
        }else if indexPath.row == 1{
         label.text = "scrollView"
        }
        return cell!
    }
    
    
    
}