//
//  QuestionnaireViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/21.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class QuestionnaireViewController: UIViewController {
    
    @IBOutlet var navbar: UINavigationBar!
    
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var nextBtn: UIButton!
    
    @IBOutlet var radio1: RadioButton!
    @IBOutlet var radio2: RadioButton!
    @IBOutlet var radio3: RadioButton!
    @IBOutlet var radio4: RadioButton!
    @IBOutlet var radio5: RadioButton!
    
    
    
    var survey2 = NSMutableDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navbar.barTintColor = UIColor.white
        
        setText(selectLanguage: BeginViewController.selectedLanguage)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func nextQ(_ sender: Any) {
        self.performSegue(withIdentifier: "Qn1toQn2", sender: self);
    }
    

    @IBAction func logSelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["attitude"] = isRadioButton.index
        
    }
    
    func setText(selectLanguage: String) {
        // according to language set text
        
        questionTitle.text = "feedback_question_1".localized(language: selectLanguage)
        
        nextBtn.setTitle("feedback_next".localized(language: selectLanguage), for: .normal)
        radio1.setTitle("feedback_very_support".localized(language: selectLanguage), for: .normal)
        radio2.setTitle("feedback_support".localized(language: selectLanguage), for: .normal)
        radio3.setTitle("feedback_soso".localized(language: selectLanguage), for: .normal)
        radio4.setTitle("feedback_unsupport".localized(language: selectLanguage), for: .normal)
        radio5.setTitle("feedback_very_unsupport".localized(language: selectLanguage), for: .normal)
        

        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let qn2 : Qn2ViewController = segue.destination as? Qn2ViewController{
            qn2.survey2 = self.survey2
        }
        
    }
    

}
