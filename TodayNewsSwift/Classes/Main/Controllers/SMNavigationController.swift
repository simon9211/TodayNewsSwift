//
//  SMNavigationController.swift
//  TodayNewsSwift
//
//  Created by xiwang wang on 2017/5/31.
//  Copyright © 2017年 xiwang wang. All rights reserved.
//

import UIKit

class SMNavigationController: UINavigationController {

    override class func initialize() {
        super.initialize()
        let naviBar = UINavigationBar.appearance()
        naviBar.barTintColor = UIColor.white
        naviBar.tintColor = SMColor(r: 0, g: 0, b: 0, a: 0.7)
        naviBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17)]
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewController.accessibilityElementCount() > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_28x28_"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }

    func navigationBack() {
        popViewController(animated: true)
    }
    
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
