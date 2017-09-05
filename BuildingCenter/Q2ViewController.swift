//
//  Q2ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/9.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Q2ViewController: UIViewController {
    
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
    @IBOutlet var btn7: UIButton!

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
        questionTitle.text = "survey02_age".localized(language: selectLanguage)
        buttomHint.text = "txt_privacy".localized(language: selectLanguage)
        
        btn1.setTitle("survey_age_below_20".localized(language: selectLanguage), for: .normal)
        btn2.setTitle("survey_age_21_25".localized(language: selectLanguage), for: .normal)
        btn3.setTitle("survey_age_26_30".localized(language: selectLanguage), for: .normal)
        btn4.setTitle("survey_age_31_40".localized(language: selectLanguage), for: .normal)
        btn5.setTitle("survey_age_41_50".localized(language: selectLanguage), for: .normal)
        btn6.setTitle("survey_age_51_60".localized(language: selectLanguage), for: .normal)
        btn7.setTitle("survey_age_over_61".localized(language: selectLanguage), for: .normal)

        
    }

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false);
    }
    
    @IBAction func clk_1(_ sender: Any) {
        self.performSegue(withIdentifier: "Q2toQ3", sender: self);
    }
    @IBAction func clk_2(_ sender: Any) {
        self.performSegue(withIdentifier: "Q2toQ3", sender: self);
    }
    @IBAction func clk_3(_ sender: Any) {
        self.performSegue(withIdentifier: "Q2toQ3", sender: self);
    }
    @IBAction func clk_4(_ sender: Any) {
        self.performSegue(withIdentifier: "Q2toQ3", sender: self);
    }
    @IBAction func clk_5(_ sender: Any) {
        self.performSegue(withIdentifier: "Q2toQ3", sender: self);
    }
    @IBAction func clk_6(_ sender: Any) {
        self.performSegue(withIdentifier: "Q2toQ3", sender: self);
    }
    @IBAction func clk_7(_ sender: Any) {
        self.performSegue(withIdentifier: "Q2toQ3", sender: self);
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
