//
//  Qn5ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Qn5ViewController: UIViewController ,ZHDropDownMenuDelegate{

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
        
        menu1.options = ["1.互動資訊牆","2.互動資訊牆","3.室內植生牆","4.智慧路燈 暨微氣候資訊站","5.智慧信箱系統","6.","7.","8.","9.","10.","11.","12."]
        menu2.options = ["1.互動資訊牆","2.互動資訊牆","3.室內植生牆","4.智慧路燈 暨微氣候資訊站","5.智慧信箱系統","6.","7.","8.","9.","10.","11.","12."]
        menu3.options = ["1.互動資訊牆","2.互動資訊牆","3.室內植生牆","4.智慧路燈 暨微氣候資訊站","5.智慧信箱系統","6.","7.","8.","9.","10.","11.","12."]
        menu4.options = ["1.互動資訊牆","2.互動資訊牆","3.室內植生牆","4.智慧路燈 暨微氣候資訊站","5.智慧信箱系統","6.","7.","8.","9.","10.","11.","12."]
        menu5.options = ["1.互動資訊牆","2.互動資訊牆","3.室內植生牆","4.智慧路燈 暨微氣候資訊站","5.智慧信箱系統","6.","7.","8.","9.","10.","11.","12."]
        
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
    
    
    
    func dropDownMenu(_ menu: ZHDropDownMenu!, didChoose index: Int) {
        print("\(menu) choosed at index \(index)")
    }
    
    //编辑完成后回调
    func dropDownMenu(_ menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func nextQ(_ sender: Any) {
        self.performSegue(withIdentifier: "Qn5toQn6", sender: self);
    }
    
    func setText(selectLanguage: String) {
        // according to language set text
        questionTitle.text = "feedback_question_5".localized(language: selectLanguage)
        nextBtn.setTitle("feedback_next".localized(language: selectLanguage), for: .normal)
        
        subTitle1.text = "feedback_free_1".localized(language: selectLanguage)
        subTitle2.text = "feedback_free_2".localized(language: selectLanguage)
        subTitle3.text = "feedback_free_3".localized(language: selectLanguage)
        subTitle4.text = "feedback_free_4".localized(language: selectLanguage)
        subTitle5.text = "feedback_free_5".localized(language: selectLanguage)

        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let qn6 : Qn6ViewController = segue.destination as? Qn6ViewController{
            qn6.survey2 = self.survey2
        }
    }
 

}
