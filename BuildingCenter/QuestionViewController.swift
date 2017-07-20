//
//  QuestionViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        let interAlert = UIAlertController(title: "問卷", message: "貴賓您好，感謝您撥冗參觀展示中心，為使本中心未來設備系統開發與服務品質的提升，請您利用簡短時間填寫本表，您所提供的資料受個資法保護，僅供問卷統、計整體分析使用，感謝您的協助。", preferredStyle: .alert)
        
        let enterButm = UIAlertAction(title: "確認", style: .default)
        
        let skipButm = UIAlertAction(title: "略過", style: .cancel)
        
        interAlert.addAction(enterButm)
        interAlert.addAction(skipButm)
        
        self.present(interAlert, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
