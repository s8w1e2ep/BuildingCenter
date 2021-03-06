//
//  Qn3ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/24.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Qn3ViewController: UIViewController ,ZHDropDownMenuDelegate{

    
    var survey2 = NSMutableDictionary()
    var deviceTw :[String] = []
    var deviceEn :[String] = []
    @IBOutlet var menu1: ZHDropDownMenu!
    @IBOutlet var menu2: ZHDropDownMenu!
    @IBOutlet var menu3: ZHDropDownMenu!
    @IBOutlet var menu4: ZHDropDownMenu!
    @IBOutlet var menu5: ZHDropDownMenu!
    
    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var nextBtn: UIButton!
    
    @IBOutlet var order1: UILabel!
    @IBOutlet var subTitle1: UILabel!
    @IBOutlet var radio1: RadioButton!
    @IBOutlet var radio2: RadioButton!
    @IBOutlet var radio3: RadioButton!
    @IBOutlet var radio4: RadioButton!
    @IBOutlet var radio5: RadioButton!
    @IBOutlet var radio6: RadioButton!
    @IBOutlet var radio7: RadioButton!
    
    @IBOutlet var order2: UILabel!
    @IBOutlet var subTitle2: UILabel!
    @IBOutlet var radio8: RadioButton!
    @IBOutlet var radio9: RadioButton!
    @IBOutlet var radio10: RadioButton!
    @IBOutlet var radio11: RadioButton!
    @IBOutlet var radio12: RadioButton!
    @IBOutlet var radio13: RadioButton!
    @IBOutlet var radio14: RadioButton!
    
    @IBOutlet var order3: UILabel!
    @IBOutlet var subTitle3: UILabel!
    @IBOutlet var radio15: RadioButton!
    @IBOutlet var radio16: RadioButton!
    @IBOutlet var radio17: RadioButton!
    @IBOutlet var radio18: RadioButton!
    @IBOutlet var radio19: RadioButton!
    @IBOutlet var radio20: RadioButton!
    @IBOutlet var radio21: RadioButton!
    
    @IBOutlet var order4: UILabel!
    @IBOutlet var subTitle4: UILabel!
    @IBOutlet var radio22: RadioButton!
    @IBOutlet var radio23: RadioButton!
    @IBOutlet var radio24: RadioButton!
    @IBOutlet var radio25: RadioButton!
    @IBOutlet var radio26: RadioButton!
    @IBOutlet var radio27: RadioButton!
    @IBOutlet var radio28: RadioButton!
    
    @IBOutlet var order5: UILabel!
    @IBOutlet var subTitle5: UILabel!
    @IBOutlet var radio29: RadioButton!
    @IBOutlet var radio30: RadioButton!
    @IBOutlet var radio31: RadioButton!
    @IBOutlet var radio32: RadioButton!
    @IBOutlet var radio33: RadioButton!
    @IBOutlet var radio34: RadioButton!
    @IBOutlet var radio35: RadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navbar.barTintColor = UIColor.white
        
        setMenucontent()
        setText(selectLanguage: BeginViewController.selectedLanguage)
        menu1.menuHeight = 250;
        menu2.menuHeight = 250;
        menu3.menuHeight = 250;
        menu4.menuHeight = 250;
        menu5.menuHeight = 250;
        
        
        menu1.delegate = self
        menu2.delegate = self
        menu3.delegate = self
        menu4.delegate = self
        menu5.delegate = self
        
    }

    
    func setText(selectLanguage: String) {
        // according to language set text
        
        questionTitle.text = "feedback_question_3".localized(language: selectLanguage)
        
        nextBtn.setTitle("feedback_next".localized(language: selectLanguage), for: .normal)
        
        order1.text = "feedback_first_order".localized(language: selectLanguage)
        order2.text = "feedback_second_order".localized(language: selectLanguage)
        order3.text = "feedback_third_order".localized(language: selectLanguage)
        order4.text = "feedback_fourth_order".localized(language: selectLanguage)
        order5.text = "feedback_fifth_order".localized(language: selectLanguage)
        
        subTitle1.text = "feedback_first_order_reason".localized(language: selectLanguage)
        subTitle2.text = "feedback_first_order_reason".localized(language: selectLanguage)
        subTitle3.text = "feedback_first_order_reason".localized(language: selectLanguage)
        subTitle4.text = "feedback_first_order_reason".localized(language: selectLanguage)
        subTitle5.text = "feedback_first_order_reason".localized(language: selectLanguage)
        
        radio1.setTitle("feedback_feature_function".localized(language: selectLanguage), for: .normal)
        radio2.setTitle("feedback_feature_beauty".localized(language: selectLanguage), for: .normal)
        radio3.setTitle("feedback_feature_operation".localized(language: selectLanguage), for: .normal)
        radio4.setTitle("feedback_feature_humility".localized(language: selectLanguage), for: .normal)
        radio5.setTitle("feedback_feature_maintainence".localized(language: selectLanguage), for: .normal)
        radio6.setTitle("feedback_feature_safe".localized(language: selectLanguage), for: .normal)
        radio7.setTitle("feedback_feature_energy".localized(language: selectLanguage), for: .normal)
        
        radio8.setTitle("feedback_feature_function".localized(language: selectLanguage), for: .normal)
        radio9.setTitle("feedback_feature_beauty".localized(language: selectLanguage), for: .normal)
        radio10.setTitle("feedback_feature_operation".localized(language: selectLanguage), for: .normal)
        radio11.setTitle("feedback_feature_humility".localized(language: selectLanguage), for: .normal)
        radio12.setTitle("feedback_feature_maintainence".localized(language: selectLanguage), for: .normal)
        radio13.setTitle("feedback_feature_safe".localized(language: selectLanguage), for: .normal)
        radio14.setTitle("feedback_feature_energy".localized(language: selectLanguage), for: .normal)
        radio15.setTitle("feedback_feature_function".localized(language: selectLanguage), for: .normal)
        radio16.setTitle("feedback_feature_beauty".localized(language: selectLanguage), for: .normal)
        radio17.setTitle("feedback_feature_operation".localized(language: selectLanguage), for: .normal)
        radio18.setTitle("feedback_feature_humility".localized(language: selectLanguage), for: .normal)
        radio19.setTitle("feedback_feature_maintainence".localized(language: selectLanguage), for: .normal)
        radio20.setTitle("feedback_feature_safe".localized(language: selectLanguage), for: .normal)
        radio21.setTitle("feedback_feature_energy".localized(language: selectLanguage), for: .normal)
        radio22.setTitle("feedback_feature_function".localized(language: selectLanguage), for: .normal)
        radio23.setTitle("feedback_feature_beauty".localized(language: selectLanguage), for: .normal)
        radio24.setTitle("feedback_feature_operation".localized(language: selectLanguage), for: .normal)
        radio25.setTitle("feedback_feature_humility".localized(language: selectLanguage), for: .normal)
        radio26.setTitle("feedback_feature_maintainence".localized(language: selectLanguage), for: .normal)
        radio27.setTitle("feedback_feature_safe".localized(language: selectLanguage), for: .normal)
        radio28.setTitle("feedback_feature_energy".localized(language: selectLanguage), for: .normal)
        radio29.setTitle("feedback_feature_function".localized(language: selectLanguage), for: .normal)
        radio30.setTitle("feedback_feature_beauty".localized(language: selectLanguage), for: .normal)
        radio31.setTitle("feedback_feature_operation".localized(language: selectLanguage), for: .normal)
        radio32.setTitle("feedback_feature_humility".localized(language: selectLanguage), for: .normal)
        radio33.setTitle("feedback_feature_maintainence".localized(language: selectLanguage), for: .normal)
        radio34.setTitle("feedback_feature_safe".localized(language: selectLanguage), for: .normal)
        radio35.setTitle("feedback_feature_energy".localized(language: selectLanguage), for: .normal)
        
        if(BeginViewController.isEnglish){
            menu1.options = deviceEn
            menu2.options = deviceEn
            menu3.options = deviceEn
            menu4.options = deviceEn
            menu5.options = deviceEn
        }
        else{
            menu1.options = deviceTw
            menu2.options = deviceTw
            menu3.options = deviceTw
            menu4.options = deviceTw
            menu5.options = deviceTw
        }
        
        menu1.placeholder = "spinner_please_select".localized(language: selectLanguage)
        menu2.placeholder = "spinner_please_select".localized(language: selectLanguage)
        menu3.placeholder = "spinner_please_select".localized(language: selectLanguage)
        menu4.placeholder = "spinner_please_select".localized(language: selectLanguage)
        menu5.placeholder = "spinner_please_select".localized(language: selectLanguage)
        
        
    }
    
    @IBAction func log1SelectedButton(_ isRadioButton:RadioButton){
        
        var tmp:String = ""
        
        if isRadioButton.isSelected {
            tmp += isRadioButton.index
        }
        for radioButton in isRadioButton.otherButtons! {
            if(radioButton.isSelected)
            {
                tmp += radioButton.index
            }
        }
        
        self.survey2["first_consider"] = tmp
        print(self.survey2)
    }
    
    @IBAction func log2SelectedButton(_ isRadioButton:RadioButton){
        
        var tmp:String = ""
        
        if isRadioButton.isSelected {
            tmp += isRadioButton.index
        }
        for radioButton in isRadioButton.otherButtons! {
            if(radioButton.isSelected)
            {
                tmp += radioButton.index
            }
        }
        
        self.survey2["second_consider"] = tmp
        print(self.survey2)
    }
    
    @IBAction func log3SelectedButton(_ isRadioButton:RadioButton){
        
        var tmp:String = ""
        
        if isRadioButton.isSelected {
            tmp += isRadioButton.index
        }
        for radioButton in isRadioButton.otherButtons! {
            if(radioButton.isSelected)
            {
                tmp += radioButton.index
            }
        }
        
        self.survey2["third_consider"] = tmp
        print(self.survey2)
    }
    @IBAction func log4SelectedButton(_ isRadioButton:RadioButton){
        
        var tmp:String = ""
        
        if isRadioButton.isSelected {
            tmp += isRadioButton.index
        }
        for radioButton in isRadioButton.otherButtons! {
            if(radioButton.isSelected)
            {
                tmp += radioButton.index
            }
        }
        
        self.survey2["fourth_consider"] = tmp
        print(self.survey2)
    }
    @IBAction func log5SelectedButton(_ isRadioButton:RadioButton){
        
        var tmp:String = ""
        
        if isRadioButton.isSelected {
            tmp += isRadioButton.index
        }
        for radioButton in isRadioButton.otherButtons! {
            if(radioButton.isSelected)
            {
                tmp += radioButton.index
            }
        }
        
        self.survey2["fifth_consider"] = tmp
        print(self.survey2)
    }
    
    
    func setMenucontent(){
        var databasehelper: Databasehelper!
        databasehelper = Databasehelper()
        
        for device in databasehelper.querydeviceTable(){
            deviceTw.append(device.name!)
            if ((device.name_en) != nil){
                deviceEn.append(device.name_en!)
            }else{
                deviceEn.append("Null")
            }
        }
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func nextQ(_ sender: Any) {
        self.performSegue(withIdentifier: "Qn3toQn4", sender: self);
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let qn4 : Qn4ViewController = segue.destination as? Qn4ViewController{
            qn4.survey2 = self.survey2
        }
    }
 
    
    func dropDownMenu(_ menu: ZHDropDownMenu!, didChoose index: Int) {
        
        if(menu.index == "1"){
        
            self.survey2["first_choise"] = menu.index
        }
        
        if(menu.index == "2"){
            self.survey2["second_choise"] = menu.index
        }
        
        if(menu.index == "3"){
            self.survey2["third_choise"] = menu.index
        }
        
        if(menu.index == "4"){
            self.survey2["fourth_choise"] = menu.index
        }
        
        if(menu.index == "5"){
            self.survey2["fifth_choise"] = menu.index
        }
        
        
        
    }
    //编辑完成后回调
    func dropDownMenu(_ menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }
    

}
