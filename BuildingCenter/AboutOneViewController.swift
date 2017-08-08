//
//  AboutOneViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/17.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class AboutOneViewController: UIViewController {

    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navbar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        content.text = "內政部建築研究所長期推動“智慧建築”，期盼透過建築與資通訊科技技術的整合，以達成人性化空間、提升生活環境品質之目的。\n\n為了讓國人了解與輕鬆體驗智慧化生活，建研所於民國97年創建“LIVING 3.0 至慧化居住空間展示中心”，作為國內智慧建築教育訓練基地，推廣智慧建築概念、提供功能體驗，進而開創國內資通訊科技產業異業結合的新契機。\n\n本展示中心以“人性關懷、創新科技、前瞻生活、環保節能、智慧永續”為主題，整合了多元的智慧化科技、創新的資通訊主動感知及控制技術，並應用情境與示範系統的建置，提供國人體驗智慧化居住及辦公空間與多種情境模式，及創照前瞻優質的生活環境與品質之願景。"
        content.contentOffset = CGPoint.zero
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
