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
    private var buttons = [UIButton]()
    private var buttonWidths = [CGFloat]()
    
    // recommend chanels
    private var recommendTopics = [SMHomeTopTitleModel]()
    
    private var topicButtonClickClosure: ((_ topicItem: SMHomeTopTitleModel)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        
        setupUI()
        
        SMNetworkTool.shareNetworkTool.loadRecomendTopic { [weak self] (topics) in
            self!.recommendTopics = topics
            self?.addTopicItemsToView()
        }
        
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(named: "add_channels_close_20x20_"), style: .plain, target: self, action: #selector(closeBBItemClick))
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    func addTopicItemsToView() {
        for (index, item) in self.recommendTopics.enumerated() {
            let button = UIButton()
            button.setTitle(item.name, for: .normal)
            button.tag = index
            button.setTitleColor(KHomeTitleNomalColor, for: .normal)
            button.setTitleColor(UIColor.red, for: .selected)
            button.backgroundColor = UIColor.yellow
            button.sizeToFit()
            button.width += kMargin
            button.addTarget(self, action: #selector(addTopicItem(btn:)), for: .touchUpInside)
            buttons.append(button)
            buttonWidths.append(button.width)
            view.addSubview(button)
        }
        setupTipicbuttonPosition()
    }
    
    @objc private func addTopicItem(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        for button in buttons {
            if button != btn {
                button.isSelected = false
            }
        }
        let item: SMHomeTopTitleModel = self.recommendTopics[btn.tag]
        topicButtonClickClosure?(item)
        closeBBItemClick()
    }
    
    func didAddTopictItemClosure(closure:@escaping (_ topicItem: SMHomeTopTitleModel)->()) {
        topicButtonClickClosure = closure
    }
    
    func setupTipicbuttonPosition() {
        var x: CGFloat = 0.0
        var y: CGFloat = 64.0
        var w: CGFloat = 0.0
        let h: CGFloat = 35
        
        for (index ,button) in self.buttons.enumerated() {
            x = kMargin + 5
            y = 64 + kMargin
            w = self.buttonWidths[index]
            if index != 0 {
                let lastbutton = self.buttons[index - 1]
                
                if lastbutton.frame.maxX + kMargin + self.buttonWidths[index] <= SCREENW {
                    ///最后一个item 可以放的下
                    x = lastbutton.frame.maxX + kMargin
                    y = lastbutton.frame.minY
                } else {
                    ///最后一个放不下
                    x = kMargin + 5
                    y = lastbutton.frame.maxY + kMargin
                }
            }
            button.frame = CGRect(x: x, y: y, width: w, height: h)
        }
    }
    
    @objc private func closeBBItemClick() {
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
