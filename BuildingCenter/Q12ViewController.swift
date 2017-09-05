//
//  Q12ViewController.swift
//  BuildingCenter
//
//  Created by wen on 2017/8/16.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class Q12ViewController: UIViewController {

    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var buttomHint: UILabel!
    
    @IBOutlet var fieldName: UITextField!
    @IBOutlet var fieldEmail: UITextField!
    @IBOutlet var confirm: UIButton!
    @IBOutlet var skip: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLayout() {
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navbar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
    }
    
    func setText(selectLanguage: String) {
        // according to language set text
        navItem.title = "survey_title".localized(language: selectLanguage)
        questionTitle.text = "survey12_personal".localized(language: selectLanguage)
        buttomHint.text = "txt_privacy".localized(language: selectLanguage)
        
        fieldName.placeholder = "name".localized(language: selectLanguage)
        fieldEmail.placeholder = "mail".localized(language: selectLanguage)
        confirm.setTitle("confirm".localized(language: selectLanguage), for: .normal)
        skip.setTitle("skip".localized(language: selectLanguage), for: .normal)
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false);
    }
    @IBAction func clkFinish(_ sender: Any) {
        self.performSegue(withIdentifier: "Q12finish", sender: self);
    }
    @IBAction func clkPass(_ sender: Any) {
        self.performSegue(withIdentifier: "Q12finish", sender: self);
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
