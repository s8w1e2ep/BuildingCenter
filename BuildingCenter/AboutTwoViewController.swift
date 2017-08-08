//
//  AboutTwoViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/17.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class AboutTwoViewController: UIViewController {

    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navbar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        content.text = "本展示中心的參訪範圍有2層樓，1F展示居住空間情境。總共引進200多項的智慧型設備，合計有90多家國內廠商參與，其中95%的設備現今都以產品化發展。部分情境應用與設備，歡迎來賓實際動手體驗。\n\n導覽系統裡有3個導覽人物，來賓可依喜好自由選擇，將由他陪伴您進行自動導覽之旅，並認識、體驗智慧生活。"
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
