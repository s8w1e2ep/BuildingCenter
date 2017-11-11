//
//  AboutOneViewController.swift
//  BuildingCenter
//
//  Created by uscc on 2017/7/17.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit
import AudioToolbox

class AboutOneViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var nextPage: UIButton!
    let databasehelper = Databasehelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        queryModeTable()
        
        setLayout()
        setText(selectLanguage: BeginViewController.selectedLanguage)
        
        
    }
    override func viewDidLayoutSubviews() {
        self.content.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if let soundUrl = Bundle.main.url(forResource: "button", withExtension: "m4a") {
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            AudioServicesPlaySystemSound(soundId)
        }
        self.performSegue(withIdentifier: "toNext", sender: self);
    }
    func queryModeTable() {
        databasehelper.querymodeTable(zoneID: "8")
        databasehelper.querymodeTable(zoneID: "9")
        databasehelper.querymodeTable(zoneID: "10")
        databasehelper.querymodeTable(zoneID: "11")
        databasehelper.querymodeTable(zoneID: "12")
        databasehelper.querymodeTable(zoneID: "13")
        databasehelper.querymodeTable(zoneID: "14")
        databasehelper.querymodeTable(zoneID: "15")
        databasehelper.querymodeTable(zoneID: "16")
        databasehelper.querymodeTable(zoneID: "17")
        databasehelper.querymodeTable(zoneID: "18")
        databasehelper.querymodeTable(zoneID: "19")
    }
    
    func setLayout() {
        // set navigation bar background image
        let navBackgroundImage:UIImage! = UIImage(named: "header_blank.png")
        self.navBar.setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
    }
    func setText(selectLanguage: String) {
        // according to language set text
        navItem.title = "origin_exhibition".localized(language: selectLanguage)
        content.text = "origin_content".localized(language: selectLanguage)
    
        nextPage.setTitle("next_page".localized(language: selectLanguage), for: .normal)
        
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
