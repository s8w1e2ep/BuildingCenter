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
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var surveyPopView: UIView!
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var buttomHint: UILabel!
    @IBOutlet var popviewTitle: UILabel!
    @IBOutlet var popviewContent: UITextView!
    @IBOutlet var popviewConfirm: UIButton!
    @IBOutlet var popviewSkip: UIButton!
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(surveyPopView)
        surveyPopView.center = self.view.center
        
        setText(selectLanguage: BeginViewController.selectedLanguage)
        setLayout()
        
        
    }
    
    func setLayout() {
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navbar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
    }
    
    func setText(selectLanguage: String) {
        // according to language set text
        navItem.title = "survey_title".localized(language: selectLanguage)
        questionTitle.text = "survey01_gender".localized(language: selectLanguage)
        buttomHint.text = "txt_privacy".localized(language: selectLanguage)
        
        popviewTitle.text = "survey_title".localized(language: selectLanguage)
        popviewContent.text = "survey_popup_text".localized(language: selectLanguage)
        popviewConfirm.setTitle("confirm".localized(language: selectLanguage), for: .normal)
        popviewSkip.setTitle("skip".localized(language: selectLanguage), for: .normal)
        
        
        btn1.setTitle("survey_gender_female".localized(language: selectLanguage), for: .normal)
        btn2.setTitle("survey_gender_male".localized(language: selectLanguage), for: .normal)
    }
    
    
    
    
    
    @IBAction func dismissSurveyPop(_ sender: Any) {
        surveyPopView.removeFromSuperview()
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
