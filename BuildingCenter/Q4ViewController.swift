//
//  Q4ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/16.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Q4ViewController: UIViewController {

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
    @IBOutlet var btn5: UIButton!
    @IBOutlet var btn6: UIButton!
    @IBOutlet var btn7: UIButton!
    @IBOutlet var btn8: UIButton!
    @IBOutlet var btn9: UIButton!
    @IBOutlet var btn10: UIButton!
    @IBOutlet var btn11: UIButton!
    @IBOutlet var btn12: UIButton!

    
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
        questionTitle.text = "survey04_occupation".localized(language: selectLanguage)
        buttomHint.text = "txt_privacy".localized(language: selectLanguage)
        
        btn1.setTitle("survey_occupation_student".localized(language: selectLanguage), for: .normal)
        btn2.setTitle("survey_occupation_real_estate".localized(language: selectLanguage), for: .normal)
        btn3.setTitle("survey_occupation_government".localized(language: selectLanguage), for: .normal)
        btn4.setTitle("survey_occupation_communication".localized(language: selectLanguage), for: .normal)
        btn5.setTitle("survey_occupation_education".localized(language: selectLanguage), for: .normal)
        btn6.setTitle("survey_occupation_finance_insurance".localized(language: selectLanguage), for: .normal)
        btn7.setTitle("survey_occupation_building".localized(language: selectLanguage), for: .normal)
        btn8.setTitle("survey_occupation_manufacture".localized(language: selectLanguage), for: .normal)
        btn9.setTitle("survey_occupation_electronic".localized(language: selectLanguage), for: .normal)
        btn10.setTitle("survey_occupation_housekeep".localized(language: selectLanguage), for: .normal)
        btn11.setTitle("survey_occupation_service".localized(language: selectLanguage), for: .normal)
        btn12.setTitle("survey_other".localized(language: selectLanguage), for: .normal)
        
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false);
    }
    
    @IBAction func clk1(_ sender: Any) {
        self.survey["career"] = 1
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk2(_ sender: Any) {
        self.survey["career"] = 2
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk3(_ sender: Any) {
        self.survey["career"] = 3
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk4(_ sender: Any) {
        self.survey["career"] = 4
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk5(_ sender: Any) {
        self.survey["career"] = 5
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk6(_ sender: Any) {
        self.survey["career"] = 6
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk7(_ sender: Any) {
        self.survey["career"] = 7
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk8(_ sender: Any) {
        self.survey["career"] = 8
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk9(_ sender: Any) {
        self.survey["career"] = 9
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk10(_ sender: Any) {
        self.survey["career"] = 10
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk11(_ sender: Any) {
        self.survey["career"] = 11
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    @IBAction func clk12(_ sender: Any) {
        self.survey["career"] = 12
        self.performSegue(withIdentifier: "Q4toQ5", sender: self);
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let q5 : Q5ViewController = segue.destination as? Q5ViewController{
            q5.survey = self.survey
        }
    }
    

}
