//
//  SMAddTopicViewController.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/6/2.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

class SMAddTopicViewController: UIViewController {

    
    ///my chanels
    var myTopics = [SMHomeTopTitleModel]()
    
    // recommend chanels
    var recommendTopics = [SMHomeTopTitleModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        
        setupUI()
        
        SMNetworkTool.shareNetworkTool.loadRecomendTopic { [weak self] (topics) in
            self!.recommendTopics = topics
             
        }
        
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(named: "add_channels_close_20x20_"), style: .plain, target: self, action: #selector(closeBBItemClick))
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    func closeBBItemClick() {
        dismiss(animated: false, completion: nil)
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
