//
//  QuestionViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet var surveyPop: UIView!
    
    @IBOutlet weak var indexofquestion: UILabel!
    @IBOutlet weak var questiontitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navbar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
        
    }
    


    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        self.view.addSubview(surveyPop)
        surveyPop.center = self.view.center
        
        
        
            }
    
    @IBAction func dismissSurvey(_ sender: Any) {
        
        surveyPop.removeFromSuperview()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
