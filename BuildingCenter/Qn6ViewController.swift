//
//  Qn6ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Qn6ViewController: UIViewController ,ZHDropDownMenuDelegate{

    var survey2 = NSMutableDictionary()
    
    @IBOutlet var menu1: ZHDropDownMenu!
    @IBOutlet var menu2: ZHDropDownMenu!
    @IBOutlet var menu3: ZHDropDownMenu!
    @IBOutlet var menu4: ZHDropDownMenu!
    @IBOutlet var menu5: ZHDropDownMenu!
    
    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var subTitle1: UILabel!
    @IBOutlet var subTitle2: UILabel!
    @IBOutlet var subTitle3: UILabel!
    @IBOutlet var subTitle4: UILabel!
    @IBOutlet var subTitle5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navbar.barTintColor = UIColor.white
        setText(selectLanguage: BeginViewController.selectedLanguage)
        
        
        
        menu1.menuHeight = 200;
        menu2.menuHeight = 200;
        menu3.menuHeight = 200;
        menu4.menuHeight = 200;
        menu5.menuHeight = 200;
        
        menu1.delegate = self
        menu2.delegate = self
        menu3.delegate = self
        menu4.delegate = self
        menu5.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func nextQ(_ sender: Any) {
        self.performSegue(withIdentifier: "Qn6toQn7", sender: self);
    }
    
    func setText(selectLanguage: String) {
        // according to language set text
        questionTitle.text = "feedback_question_6".localized(language: selectLanguage)
        nextBtn.setTitle("feedback_next".localized(language: selectLanguage), for: .normal)
        
        subTitle1.text = "feedback_free_1".localized(language: selectLanguage)
        subTitle2.text = "feedback_free_2".localized(language: selectLanguage)
        subTitle3.text = "feedback_free_3".localized(language: selectLanguage)
        subTitle4.text = "feedback_free_4".localized(language: selectLanguage)
        subTitle5.text = "feedback_free_5".localized(language: selectLanguage)
        
        if(BeginViewController.isEnglish){
            menu1.options = QuestionnaireViewController.deviceEn
            menu2.options = QuestionnaireViewController.deviceEn
            menu3.options = QuestionnaireViewController.deviceEn
            menu4.options = QuestionnaireViewController.deviceEn
            menu5.options = QuestionnaireViewController.deviceEn
        }
        else{
            menu1.options = QuestionnaireViewController.deviceTw
            menu2.options = QuestionnaireViewController.deviceTw
            menu3.options = QuestionnaireViewController.deviceTw
            menu4.options = QuestionnaireViewController.deviceTw
            menu5.options = QuestionnaireViewController.deviceTw
        }
        
        menu1.placeholder = "spinner_please_select".localized(language: selectLanguage)
        menu2.placeholder = "spinner_please_select".localized(language: selectLanguage)
        menu3.placeholder = "spinner_please_select".localized(language: selectLanguage)
        menu4.placeholder = "spinner_please_select".localized(language: selectLanguage)
        menu5.placeholder = "spinner_please_select".localized(language: selectLanguage)
        
        
    }
    
    func dropDownMenu(_ menu: ZHDropDownMenu!, didChoose index: Int) {
        if(menu.index == "1"){
            
            self.survey2["impression1"] = menu.index
        }
        
        if(menu.index == "2"){
            self.survey2["impression2"] = menu.index
        }
        
        if(menu.index == "3"){
            self.survey2["impression3"] = menu.index
        }
        
        if(menu.index == "4"){
            self.survey2["impression4"] = menu.index
        }
        
        if(menu.index == "5"){
            self.survey2["impression5"] = menu.index
        }
    }
    
    //编辑完成后回调
    func dropDownMenu(_ menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let qn7 : Qn7ViewController = segue.destination as? Qn7ViewController{
            qn7.survey2 = self.survey2
        }
    }
    

}
