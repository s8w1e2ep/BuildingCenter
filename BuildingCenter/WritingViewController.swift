//
//  WritingViewController.swift
//  BuildingCenter
//
//  Created by Chi Li on 2017/9/4.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var image: UIImage!
    var template: UIImage!
    var index: Int!
    var text = [String] ()
    var area: String!
    var textIndex: Int!
    var zoneTw = [String!] ()
    var zoneEn = [String!] ()
    
    @IBOutlet weak var selectItem: UILabel!
    @IBOutlet weak var menu: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var content: UITextField!
    @IBOutlet weak var writeTextView: UIView!
    @IBOutlet weak var buildTextView: UIView!
    @IBOutlet weak var viewControl: UISegmentedControl!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var chooseAreaLabel: UILabel!
    
    @IBOutlet weak var Radio1: RadioButton!
    @IBOutlet weak var Radio2: RadioButton!
    @IBOutlet weak var Radio3: RadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text.append(Radio1.title(for: .normal)!)
        text.append(Radio2.title(for: .normal)!)
        text.append(Radio3.title(for: .normal)!)
        zoneTw.append("請選擇")
        zoneEn.append("Your Selection")
        setMenucontent()
        setText(selectLanguage: BeginViewController.selectedLanguage)
        
        self.menu.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //self.menu.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setText(selectLanguage: String){
        viewControl.setTitle("write_text".localized(language:selectLanguage), forSegmentAt: 0)
        viewControl.setTitle("build_text".localized(language:selectLanguage), forSegmentAt: 1)
        navItem.title = "text_master".localized(language:selectLanguage)
        nextBtn.setTitle("nextstep".localized(language:selectLanguage),for: .normal)
        content.placeholder = "template_content".localized(language:selectLanguage)
        chooseAreaLabel.text = "choose_area".localized(language:selectLanguage)
        selectItem.text = "spinner_please_select".localized(language:selectLanguage)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(BeginViewController.isEnglish){
            return zoneEn.count
        }
        else{
            return zoneTw.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath) as! WritingAreaViewCell
        if(BeginViewController.isEnglish){
            cell.areaName.text = zoneEn[indexPath.row]
        }
        else{
            cell.areaName.text = zoneTw[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(BeginViewController.isEnglish){
            selectItem.text = zoneEn[indexPath.row]
        }
        else{
            selectItem.text = zoneTw[indexPath.row]
        }
        menuView.isHidden = !menu.isHidden
    }
    
    @IBAction func OnChecklistBtnAction(_ sender: Any) {
        print("3.zoneTW.count = \(zoneTw.count)")
        print("3.zoneEn.count = \(zoneEn.count)")

        menuView.isHidden = !menuView.isHidden
    }
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        
        if viewControl.selectedSegmentIndex == 0
        {
            writeTextView.isHidden = false
            buildTextView.isHidden = true
        }
        
        if viewControl.selectedSegmentIndex == 1
        {
            writeTextView.isHidden = true
            buildTextView.isHidden = false
        }
        
    }
    
    func setMenucontent(){
        var databasehelper: Databasehelper!
        databasehelper = Databasehelper()
        
        for zone in databasehelper.queryzoneTable(){
            zoneTw.append(zone.name!)
            if ((zone.name_en) != nil){
                zoneEn.append(zone.name_en!)
            }else{
                zoneEn.append("Null")
            }
        }
        
        
    }
    
    @IBAction func logSelectedButton(_ isRadioButton:RadioButton){
        
        textIndex = Int(isRadioButton.index)! - 1
        
    }
//
    func dropDownMenu(_ menu: ZHDropDownMenu!, didChoose index: Int) {
        
         print("menu.index = \(menu.index)")
        
        /*
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
        */
        
    }

//
    func dropDownMenu(_ menu: ZHDropDownMenu!, didInput text: String!) {
        print("\(menu) input text \(text)")
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated:true)
    }
    
    @IBAction func nextButtononClick(_ sender: Any) {
        //if
        
        if textIndex != nil{
            self.performSegue(withIdentifier: "WritingToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tagimage = image
        let tagtemplate = template
        let tagindex = index
        var tagtext: String!
        if viewControl.selectedSegmentIndex == 1{
            tagtext = text[textIndex]
        }
        else{
            tagtext = content.text
        }
        
        let controller = segue.destination as! ResultViewController
        controller.image = tagimage
        controller.template = tagtemplate
        controller.index = tagindex
        controller.text = tagtext
    }

}
