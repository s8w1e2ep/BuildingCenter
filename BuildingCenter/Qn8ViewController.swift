//
//  Qn8ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Qn8ViewController: UIViewController {

    var survey2 = NSMutableDictionary()
    
    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var radio1: RadioButton!
    @IBOutlet var radio2: RadioButton!
    @IBOutlet var radio3: RadioButton!
    @IBOutlet var radio4: RadioButton!
    @IBOutlet var radio5: RadioButton!
    
    
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
    @IBAction func Qnfinish(_ sender: Any) {
        self.performSegue(withIdentifier: "Qnfinish", sender: self);
    }
    
    func setText(selectLanguage: String) {
        // according to language set text
        questionTitle.text = "feedback_question_8".localized(language: selectLanguage)
        nextBtn.setTitle("feedback_next".localized(language: selectLanguage), for: .normal)
        
        radio1.setTitle("feedback_price_10k".localized(language: selectLanguage), for: .normal)
        radio2.setTitle("feedback_price_50k".localized(language: selectLanguage), for: .normal)
        radio3.setTitle("feedback_price_100k".localized(language: selectLanguage), for: .normal)
        radio4.setTitle("feedback_price_200k".localized(language: selectLanguage), for: .normal)
        radio5.setTitle("feedback_price_over_200k".localized(language: selectLanguage), for: .normal)
        
        
        
    }
    
    @IBAction func logSelectedButton(_ isRadioButton:RadioButton){
        
        self.survey2["reasonable_price"] = isRadioButton.index
    }
    
    @IBAction func clkFinish(_ sender: Any) {
        
        if let JsonData = try? JSONSerialization.data(withJSONObject: self.survey2, options: [])
        {
            print(JsonData)
            let JsontoUtf8 = String(data:JsonData,encoding:.utf8)
            var stringUrl = DatabaseUtilizer.feedbackURL + "?feedback="
            stringUrl += JsontoUtf8!
            print(stringUrl)
            
            
            if let encodedURL = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                let url = NSURL(string: encodedURL)
                do{
                    let html = try String(contentsOf: url! as URL)
                    print(html)
                }catch{
                    print(error)
                }
                
            }
 
            
        }
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
