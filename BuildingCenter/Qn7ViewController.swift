//
//  Qn7ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Qn7ViewController: UIViewController {

    var survey2 = NSMutableDictionary()
    
    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var radio1: RadioButton!
    @IBOutlet var radio2: RadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navbar.barTintColor = UIColor.white
        setText(selectLanguage: BeginViewController.selectedLanguage)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func nextQ(_ sender: Any) {
        self.performSegue(withIdentifier: "Qn7toQn8", sender: self);
    }
    
    
    func setText(selectLanguage: String) {
        // according to language set text
        questionTitle.text = "feedback_question_7".localized(language: selectLanguage)
        nextBtn.setTitle("feedback_next".localized(language: selectLanguage), for: .normal)
        radio1.setTitle("feedback_nicht".localized(language: selectLanguage), for: .normal)
        radio2.setTitle("feedback_ja".localized(language: selectLanguage), for: .normal)
        
    }
    
    @IBAction func logSelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["buy"] = isRadioButton.index
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let qn8 : Qn8ViewController = segue.destination as? Qn8ViewController{
            qn8.survey2 = self.survey2
        }
    }
 

}
