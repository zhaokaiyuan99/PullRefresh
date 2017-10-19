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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
       
        
        // tas.assaf()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MyScrollViewController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
      
            let label = UILabel()
            label.frame = CGRect(origin: .zero, size: CGSize(width: 320, height: 36))
            label.font = UIFont.boldSystemFont(ofSize: 13)
            label.textColor = UIColor.black
            label.backgroundColor = UIColor.clear
            label.textAlignment = .center
            cell.contentView.addSubview(label)
            label.tag = 1000001
        label.text = "scrollView"
        
        return cell
    }
    
    
    
}
