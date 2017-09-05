//
//  Q5ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/16.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Q5ViewController: UIViewController {

    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var buttomHint: UILabel!
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var btn6: UIButton!
    
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
        questionTitle.text = "survey05_experience".localized(language: selectLanguage)
        buttomHint.text = "txt_privacy".localized(language: selectLanguage)
        
        btn1.setTitle("survey_exp_none".localized(language: selectLanguage), for: .normal)
        btn2.setTitle("survey_exp_1y".localized(language: selectLanguage), for: .normal)
        btn3.setTitle("survey_exp_3y".localized(language: selectLanguage), for: .normal)
        btn4.setTitle("survey_exp_5y".localized(language: selectLanguage), for: .normal)
        btn5.setTitle("survey_exp_10y".localized(language: selectLanguage), for: .normal)
        btn6.setTitle("survey_exp_over_10y".localized(language: selectLanguage), for: .normal)
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false);
    }

    @IBAction func clk1(_ sender: Any) {
        self.performSegue(withIdentifier: "Q5toQ6", sender: self);
    }
    @IBAction func clk2(_ sender: Any) {
        self.performSegue(withIdentifier: "Q5toQ6", sender: self);
    }
    @IBAction func clk3(_ sender: Any) {
        self.performSegue(withIdentifier: "Q5toQ6", sender: self);
    }
    @IBAction func clk4(_ sender: Any) {
        self.performSegue(withIdentifier: "Q5toQ6", sender: self);
    }
    
    @IBAction func clk5(_ sender: Any) {
        self.performSegue(withIdentifier: "Q5toQ6", sender: self);
    }
    @IBAction func clk6(_ sender: Any) {
        self.performSegue(withIdentifier: "Q5toQ6", sender: self);
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
