//
//  QuestionViewController.swift
//  BuildingCenter
//
//  Created by 李佳穎 on 18/07/2017.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var surveyPop: UIView!
    
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
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: false);
    }
    
    
    
    @IBAction func clkGirl(_ sender: Any) {
        self.performSegue(withIdentifier: "Q1toQ2", sender: self);
    }
    
   
    @IBAction func clkBoy(_ sender: Any) {
        self.performSegue(withIdentifier: "Q1toQ2", sender: self);
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
