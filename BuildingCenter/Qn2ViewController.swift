//
//  Qn2ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/24.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Qn2ViewController: UIViewController {

    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var nextBtn: UIButton!
    
    
    @IBOutlet var subTitle1: UILabel!
    @IBOutlet var radio1: RadioButton!
    @IBOutlet var radio2: RadioButton!
    @IBOutlet var radio3: RadioButton!
    @IBOutlet var radio4: RadioButton!
    @IBOutlet var radio5: RadioButton!
    
    @IBOutlet var subTitle2: UILabel!
    @IBOutlet var radio6: RadioButton!
    @IBOutlet var radio7: RadioButton!
    @IBOutlet var radio8: RadioButton!
    @IBOutlet var radio9: RadioButton!
    @IBOutlet var radio10: RadioButton!
    
    @IBOutlet var subTitle3: UILabel!
    @IBOutlet var radio11: RadioButton!
    @IBOutlet var radio12: RadioButton!
    @IBOutlet var radio13: RadioButton!
    @IBOutlet var radio14: RadioButton!
    @IBOutlet var radio15: RadioButton!
    
    @IBOutlet var subTitle4: UILabel!
    @IBOutlet var radio16: RadioButton!
    @IBOutlet var radio17: RadioButton!
    @IBOutlet var radio18: RadioButton!
    @IBOutlet var radio19: RadioButton!
    @IBOutlet var radio20: RadioButton!
    
    @IBOutlet var subTitle5: UILabel!
    @IBOutlet var radio21: RadioButton!
    @IBOutlet var radio22: RadioButton!
    @IBOutlet var radio23: RadioButton!
    @IBOutlet var radio24: RadioButton!
    @IBOutlet var radio25: RadioButton!
    
    @IBOutlet var subTitle6: UILabel!
    @IBOutlet var radio26: RadioButton!
    @IBOutlet var radio27: RadioButton!
    @IBOutlet var radio28: RadioButton!
    @IBOutlet var radio29: RadioButton!
    @IBOutlet var radio30: RadioButton!
    
    @IBOutlet var subTitle7: UILabel!
    @IBOutlet var radio31: RadioButton!
    @IBOutlet var radio32: RadioButton!
    @IBOutlet var radio33: RadioButton!
    @IBOutlet var radio34: RadioButton!
    @IBOutlet var radio35: RadioButton!
    
    @IBOutlet var subTitle8: UILabel!
    @IBOutlet var radio36: RadioButton!
    @IBOutlet var radio37: RadioButton!
    @IBOutlet var radio38: RadioButton!
    @IBOutlet var radio39: RadioButton!
    @IBOutlet var radio40: RadioButton!
    
    
    
    
    
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
    
    
    func setText(selectLanguage: String) {
        // according to language set text
        
        questionTitle.text = "feedback_question_2".localized(language: selectLanguage)
        subTitle1.text = "feedback_function".localized(language: selectLanguage)
        subTitle2.text = "feedback_beauty".localized(language: selectLanguage)
        subTitle3.text = "feedback_operability".localized(language: selectLanguage)
        subTitle4.text = "feedback_humility".localized(language: selectLanguage)
        subTitle5.text = "feedback_price".localized(language: selectLanguage)
        subTitle6.text = "feedback_maintenance".localized(language: selectLanguage)
        subTitle7.text = "feedback_safetly".localized(language: selectLanguage)
        subTitle8.text = "feedback_energy".localized(language: selectLanguage)
        
        nextBtn.setTitle("feedback_next".localized(language: selectLanguage), for: .normal)
        radio1.setTitle("feedback_very_important".localized(language: selectLanguage), for: .normal)
        radio2.setTitle("feedback_important".localized(language: selectLanguage), for: .normal)
        radio3.setTitle("feedback_sosososo".localized(language: selectLanguage), for: .normal)
        radio4.setTitle("feedback_unimportant".localized(language: selectLanguage), for: .normal)
        radio5.setTitle("feedback_very_unimportant".localized(language: selectLanguage), for: .normal)
        radio6.setTitle("feedback_very_important".localized(language: selectLanguage), for: .normal)
        radio7.setTitle("feedback_important".localized(language: selectLanguage), for: .normal)
        radio8.setTitle("feedback_sosososo".localized(language: selectLanguage), for: .normal)
        radio9.setTitle("feedback_unimportant".localized(language: selectLanguage), for: .normal)
        radio10.setTitle("feedback_very_unimportant".localized(language: selectLanguage), for: .normal)
        radio11.setTitle("feedback_very_important".localized(language: selectLanguage), for: .normal)
        radio12.setTitle("feedback_important".localized(language: selectLanguage), for: .normal)
        radio13.setTitle("feedback_sosososo".localized(language: selectLanguage), for: .normal)
        radio14.setTitle("feedback_unimportant".localized(language: selectLanguage), for: .normal)
        radio15.setTitle("feedback_very_unimportant".localized(language: selectLanguage), for: .normal)
        radio16.setTitle("feedback_very_important".localized(language: selectLanguage), for: .normal)
        radio17.setTitle("feedback_important".localized(language: selectLanguage), for: .normal)
        radio18.setTitle("feedback_sosososo".localized(language: selectLanguage), for: .normal)
        radio19.setTitle("feedback_unimportant".localized(language: selectLanguage), for: .normal)
        radio20.setTitle("feedback_very_unimportant".localized(language: selectLanguage), for: .normal)
        radio21.setTitle("feedback_very_important".localized(language: selectLanguage), for: .normal)
        radio22.setTitle("feedback_important".localized(language: selectLanguage), for: .normal)
        radio23.setTitle("feedback_sosososo".localized(language: selectLanguage), for: .normal)
        radio24.setTitle("feedback_unimportant".localized(language: selectLanguage), for: .normal)
        radio25.setTitle("feedback_very_unimportant".localized(language: selectLanguage), for: .normal)
        radio26.setTitle("feedback_very_important".localized(language: selectLanguage), for: .normal)
        radio27.setTitle("feedback_important".localized(language: selectLanguage), for: .normal)
        radio28.setTitle("feedback_sosososo".localized(language: selectLanguage), for: .normal)
        radio29.setTitle("feedback_unimportant".localized(language: selectLanguage), for: .normal)
        radio30.setTitle("feedback_very_unimportant".localized(language: selectLanguage), for: .normal)
        radio31.setTitle("feedback_very_important".localized(language: selectLanguage), for: .normal)
        radio32.setTitle("feedback_important".localized(language: selectLanguage), for: .normal)
        radio33.setTitle("feedback_sosososo".localized(language: selectLanguage), for: .normal)
        radio34.setTitle("feedback_unimportant".localized(language: selectLanguage), for: .normal)
        radio35.setTitle("feedback_very_unimportant".localized(language: selectLanguage), for: .normal)
        radio36.setTitle("feedback_very_important".localized(language: selectLanguage), for: .normal)
        radio37.setTitle("feedback_important".localized(language: selectLanguage), for: .normal)
        radio38.setTitle("feedback_sosososo".localized(language: selectLanguage), for: .normal)
        radio39.setTitle("feedback_unimportant".localized(language: selectLanguage), for: .normal)
        radio40.setTitle("feedback_very_unimportant".localized(language: selectLanguage), for: .normal)
        
    }
    
    @IBAction func logSelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["functionality"] = isRadioButton.index
        
    }
    @IBAction func log1SelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["visual"] = isRadioButton.index
        
    }
    @IBAction func log2SelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["operability"] = isRadioButton.index
        
    }
    @IBAction func log3SelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["user_friendly"] = isRadioButton.index
        
    }
    @IBAction func log4SelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["price"] = isRadioButton.index
        
    }
    @IBAction func log5SelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["maintenance"] = isRadioButton.index
        
    }
    @IBAction func log6SelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["safety"] = isRadioButton.index
        
    }
    @IBAction func log7SelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["energy"] = isRadioButton.index
        
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func nextQ(_ sender: Any) {
        self.performSegue(withIdentifier: "Qn2toQn3", sender: self);
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let qn3 : Qn3ViewController = segue.destination as? Qn3ViewController{
            qn3.survey2 = self.survey2
        }
    }
    

}
