//
//  SMHomeTopicController.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/2.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

class SMHomeTopicController: UITableViewController {

    ///上一次选中的tabbar index
    var lastSelectedIndex = Int()
    
    private var pullRefreshTime: TimeInterval?
    
    var topTitle: SMHomeTopTitleModel? = nil
    
//    private var newsTopics = 
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
