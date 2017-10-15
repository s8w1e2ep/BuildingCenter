//
//  WritingViewController.swift
//  BuildingCenter
//
//  Created by Chi Li on 2017/9/4.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    var image: UIImage!
    var template: UIImage!
    var index: Int!
    var text = [String] ()
    var area: String!
    var textIndex: Int!
    var zoneTw = [String!] ()
    var zoneEn = [String!] ()
    var zoneIndex: Int!
    var textSelectZone: String!
    var textSelectContent: String!
    
    var currentTextField: UITextField?
    var isKeyboardShown = false
    
    @IBOutlet weak var chooseAreaView: UIView!
    
    @IBOutlet weak var promptView: UIView!
    @IBOutlet weak var prompt: UILabel!
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
        
        setTapAction()
        text.append(Radio1.title(for: .normal)!)
        text.append(Radio2.title(for: .normal)!)
        text.append(Radio3.title(for: .normal)!)
        zoneIndex = 0
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
    
    func setTapAction(){
        chooseAreaView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(WritingViewController.OnchooseAreaViewAction))
        
        chooseAreaView.addGestureRecognizer(tap)
    }
    
    func setText(selectLanguage: String){
        viewControl.setTitle("write_text".localized(language:selectLanguage), forSegmentAt: 0)
        viewControl.setTitle("build_text".localized(language:selectLanguage), forSegmentAt: 1)
        navItem.title = "text_master".localized(language:selectLanguage)
        nextBtn.setTitle("nextstep".localized(language:selectLanguage),for: .normal)
        content.placeholder = "template_content".localized(language:selectLanguage)
        chooseAreaLabel.text = "choose_area".localized(language:selectLanguage)
        selectItem.text = "spinner_please_select".localized(language:selectLanguage)
        textSelectZone = "please_select_zone".localized(language:selectLanguage)
        textSelectContent = "please_write_content".localized(language:selectLanguage)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let countOfWords = string.characters.count + textField.text!.characters.count - range.length
        if countOfWords > 30{
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        content.resignFirstResponder()
    }
    
    func keyboardWillShow(note: NSNotification) {
        if isKeyboardShown {
            return
        }
        if (currentTextField != content) {
            return
        }
        let keyboardAnimationDetail = note.userInfo as! [String: AnyObject]
        let duration = TimeInterval(keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
        let keyboardFrameValue = keyboardAnimationDetail[UIKeyboardFrameBeginUserInfoKey]! as! NSValue
        let keyboardFrame = keyboardFrameValue.cgRectValue
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -keyboardFrame.size.height)
        })
        isKeyboardShown = true
    }
    
    func keyboardWillHide(note: NSNotification) {
        let keyboardAnimationDetail = note.userInfo as! [String: AnyObject]
        let duration = TimeInterval(keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -self.view.frame.origin.y)
        })
        isKeyboardShown = false
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
        zoneIndex = indexPath.row
        menuView.isHidden = !menu.isHidden
    }
    
    @IBAction func OnmenuViewAction(_ sender: Any) {
        menuView.isHidden = !menuView.isHidden
    }
    
    func OnchooseAreaViewAction(){
        menuView.isHidden = !menuView.isHidden
    }
    
    @IBAction func OnChecklistBtnAction(_ sender: Any) {
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
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated:true)
    }
    
    @IBAction func nextButtononClick(_ sender: Any) {
        if zoneIndex != 0{
            if viewControl.selectedSegmentIndex == 1{
                if textIndex != nil{
                    self.performSegue(withIdentifier: "WritingToResult", sender: self)
                }
                else{
                    prompt.text = textSelectContent
                    showPrompt()
                    hiddenPrompt()
                }
            }
            else{
                if content.text != nil{
                    self.performSegue(withIdentifier: "WritingToResult", sender: self)
                }
            }
        }
        else{
            prompt.text = textSelectZone
            showPrompt()
            hiddenPrompt()
        }
    }

    func showPrompt(){
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut, .repeat, .autoreverse], animations: { self.promptView.alpha = 1 }, completion: {_ in self.promptView.isHidden = false })
        DispatchQueue.main.asyncAfter(deadline: (.now()+1.5), execute: { self.promptView.layer.removeAllAnimations()})
    }
    
    func hiddenPrompt(){
        UIView.animate(withDuration: 1, delay: 3, options: [.curveEaseOut, .repeat, .autoreverse], animations: { self.promptView.alpha = 0 }, completion: {_ in self.promptView.isHidden = true })
        DispatchQueue.main.asyncAfter(deadline: (.now()+1.5), execute: { self.promptView.layer.removeAllAnimations()})
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
