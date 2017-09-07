//
//  Q3ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/9.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Q3ViewController: UIViewController {
    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var buttomHint: UILabel!
    
    //struct survey 
    var survey = NSMutableDictionary()
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLayout() {
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navbar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
    }
    
    func setText(selectLanguage: String) {
        // according to language set text
        navItem.title = "survey_title".localized(language: selectLanguage)
        questionTitle.text = "survey03_education".localized(language: selectLanguage)
        buttomHint.text = "txt_privacy".localized(language: selectLanguage)
        
        btn1.setTitle("survey_education_high_school".localized(language: selectLanguage), for: .normal)
        btn2.setTitle("survey_education_college".localized(language: selectLanguage), for: .normal)
        btn3.setTitle("survey_education_university".localized(language: selectLanguage), for: .normal)
        btn4.setTitle("survey_education_master".localized(language: selectLanguage), for: .normal)
        
        
    }
    

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false);
    }

    @IBAction func clk1(_ sender: Any) {
        self.survey["education"] = 1
        self.performSegue(withIdentifier: "Q3toQ4", sender: self);
    }
    @IBAction func clk2(_ sender: Any) {
        self.survey["education"] = 2
        self.performSegue(withIdentifier: "Q3toQ4", sender: self);
    }
    @IBAction func clk3(_ sender: Any) {
        self.survey["education"] = 3
        self.performSegue(withIdentifier: "Q3toQ4", sender: self);
    }
    @IBAction func clk4(_ sender: Any) {
        self.survey["education"] = 4
        self.performSegue(withIdentifier: "Q3toQ4", sender: self);
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let q4 : Q4ViewController = segue.destination as? Q4ViewController{
            q4.survey = self.survey
        }
    }
    

}
